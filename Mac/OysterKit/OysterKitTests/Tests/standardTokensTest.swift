//
//  standardTokensTest.swift
//  OysterKit Mac
//
//  Created by Nigel Hughes on 03/07/2014.
//  Copyright (c) 2014 RED When Excited Limited. All rights reserved.
//

import XCTest
import OysterKit

class standardTokensTest: XCTestCase {

    var tokenizer = Tokenizer()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tokenizer = Tokenizer()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNumber(){
        tokenizer.branch(
            OysterKit.number,
            OysterKit.eot
        )
        
        let testStrings = [
            "1.5" : "float",
            "1" : "integer",
            "-1" : "integer",
            "+1" : "integer",
            "+10" : "integer",
            "1.5e10" : "float",
            "-1.5e10": "float",
            "-1.5e-10": "float",
        ]
        
        for (number:String,token:String) in testStrings{
            let newTokenizer = Tokenizer(states: [
                OysterKit.number,
                OysterKit.eot
                ])
            var tokens:Array<Token> = newTokenizer.tokenize(number)
            
            XCTAssert(tokens.count == 1, "Failed to generate "+token+" from "+number+", exactly one token should have been created")

            if tokens.count > 0 {
                let actualToken:Token = tokens[0]
                
                XCTAssert(actualToken.name == token, "Failed to generate "+token+" from "+number+", instead received "+actualToken.description())                
            }
        }
    }
    
    func testSimpleString(){
        tokenizer.branch(
            OysterKit.blanks,
            OysterKit.number,
            OysterKit.word,
            OysterKit.eot
        )
        
        let parsingTest = "Short 10 string"
        
        XCTAssert(tokenizer.tokenize(parsingTest) == [token("word",chars:"Short"), token("blank",chars:" "), token("integer",chars:"10"), token("blank",chars:" "), token("word",chars:"string"), ])
    }
    
}
