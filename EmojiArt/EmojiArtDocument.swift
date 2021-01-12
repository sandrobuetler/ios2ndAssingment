import SwiftUI
import Combine

class EmojiArtDocument: ObservableObject, Hashable, Equatable, Identifiable {
    static func == (lhs: EmojiArtDocument, rhs: EmojiArtDocument) -> Bool {
        lhs.id == rhs.id
    }

    let id: UUID

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private var currentTime: Double = 0
    
    var timer: TimeCounter
    
    static let palette: String =  "🐶🐱🐹🐰🦊🐼🐨🐯🐸🐵🐧🐦🐤🦆🦅🦇🐺"

    @Published var bgColor: Color = Color.white
    @Published private var emojiArt: EmojiArt
    private var autosaveCancellable: AnyCancellable?

    var url: URL? {
        didSet { save(emojiArt) }
    }

    init(url: URL) {
        self.id = UUID()
        self.url = url
        let defaultsKey = "EmojiArtDocument.\(id.uuidString)"
        timer = TimeCounter(totalUsedTime: UserDefaults.standard.integer(forKey: "\(defaultsKey).totalUsedTime"))
        
        if let loadedColor = UserDefaults.standard.data(forKey: "\(defaultsKey).bgColor") {
            do {
                if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(loadedColor) as? UIColor {
                    bgColor = Color(color)
                }
            } catch {
                print("No Color found")
            }
        }
        self.emojiArt = EmojiArt(json: try? Data(contentsOf: url)) ?? EmojiArt()
        fetchBackgroundImageData()
        autosaveCancellable = $emojiArt.sink { emojiArt in
            self.save(emojiArt)
        }
    }

    private func save(_ emojiArt: EmojiArt) {
        if url != nil {
            try? emojiArt.json?.write(to: url!)
        }
    }
    
    @Published private(set) var backgroundImage: UIImage?
    @Published var steadyStateZoomScale: CGFloat = 1.0
    @Published var steadyStatePanOffset: CGSize = .zero

    var emojis: [EmojiArt.Emoji] {emojiArt.emojis}
    
    // MARK: - Intents
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    @available(iOS 14.0, *)
    func saveUserSettings() {
        let defaultsKey = "EmojiArtDocument.\(id.uuidString)"
        var colorData: NSData?
        let bgColor: UIColor? = UIColor(self.bgColor)
        if let color = bgColor {
              do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
                colorData = data
              } catch {
                print("Could not save color to defaults")
              }
            }
        UserDefaults.standard.set(colorData, forKey: "\(defaultsKey).bgColor")
        
    }
    
    var backgroundURL: URL? {
        get {
            emojiArt.backgroundURL
        }
        set {
            emojiArt.backgroundURL = newValue?.imageURL
            fetchBackgroundImageData()
        }
    }

    private var fetchImageCancellable: AnyCancellable?
    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL?.imageURL {
            fetchImageCancellable?.cancel()
            let publisher = URLSession.shared.dataTaskPublisher(for: url)
                .map { data, response in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
            fetchImageCancellable = publisher.assign(to: \.backgroundImage, on: self)
        }
    }  
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
