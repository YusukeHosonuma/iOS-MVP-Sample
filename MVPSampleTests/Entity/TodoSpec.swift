//
//  TodoSpec.swift
//  MVPSampleTests
//
//  Created by Yusuke Hosonuma on 2018/02/25.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import MVPSample

class TodoSpec: QuickSpec {
    override func spec() {
        describe("isMatch") {
            let todo = Todo.new(title: "apple")
            describe("match") {
                it("partial match is OK") {
                    expect(todo.isMatch("ap")).to(beTrue())
                    expect(todo.isMatch("pp")).to(beTrue())
                }
                it("ignore case") {
                    expect(todo.isMatch("PP")).to(beTrue())
                }
            }
            describe("not match") {
                it("not match") {
                    expect(todo.isMatch("ppx")).to(beFalse())
                }
            }
        }
    }
}
