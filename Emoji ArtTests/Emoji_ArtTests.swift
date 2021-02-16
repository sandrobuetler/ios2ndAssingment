//
//  Emoji_ArtTests.swift
//  Emoji ArtTests
//
//  Created by Sandro Bütler on 16.02.21.
//  Copyright © 2021 fhnw. All rights reserved.
//

import XCTest
//quelle: https://www.youtube.com/watch?v=-eiY9eauJr0&ab_channel=iOSAcademy
@testable import Emoji_Art

class Emoji_ArtTests: XCTestCase {

    private var emojiArt = EmojiArt()
    
    override func setUpWithError() throws {
        //quelle: https://www.swiftbysundell.com/basics/unit-testing/
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        emojiArt = EmojiArt()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddEmojiTextEmpty(){
        //given
        let givenEmojiCount = emojiArt.emojis.count
        
        //when
        emojiArt.addEmoji("", x: 50, y: 50, size: 1)
        
        //then
        let emojiCount = emojiArt.emojis.count
        XCTAssertEqual(emojiCount, givenEmojiCount)
    }
    
    func testAddEmojiSizeGreater(){
        //given
        let givenEmojiCount = emojiArt.emojis.count
        
        //when
        emojiArt.addEmoji("🙈", x: 0, y: 0, size: 2)
        
        //then
        let emojiCount = emojiArt.emojis.count
        XCTAssertEqual(emojiCount, givenEmojiCount)
    }
    
    func testAddEmojiIdIncrements(){
        //given
        
        //when
        emojiArt.addEmoji("🙈", x: 0, y: 0, size: 1)
        emojiArt.addEmoji("🙈", x: 0, y: 0, size: 1)
        
        //then
        XCTAssertEqual(emojiArt.emojis[1].id, emojiArt.emojis[0].id + 1)
        XCTAssertEqual(emojiArt.emojis.count, emojiArt.emojis[emojiArt.emojis.count - 1].id)
        
        //when
        emojiArt.addEmoji("", x: 0, y: 0, size: 1)
        emojiArt.addEmoji("🙈", x: 0, y: 0, size: 2)
        
        //then
        XCTAssertEqual(emojiArt.emojis.count, 2)
    }
}
