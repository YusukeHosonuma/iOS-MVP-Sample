//
//  TodoTests.swift
//  MVPSampleTests
//
//  Created by Yusuke Hosonuma on 2018/02/24.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import XCTest
@testable import MVPSample

class TodoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let todo = Todo.new(title: "apple")
        
        // 先頭マッチOK
        XCTAssertTrue(todo.isMatch("ap"))
        
        // 部分マッチOK
        XCTAssertTrue(todo.isMatch("pp"))
        
        // 大文字・小文字は無視してマッチOK
        XCTAssertTrue(todo.isMatch("PP"))
        
        // 部分マッチNG
        XCTAssertFalse(todo.isMatch("ppx"))
    }
}
