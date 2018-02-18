//
//  AppContext.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/18.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

let appContext = AppContext()

class AppContext {
    fileprivate init() {}

    let todoList = TodoList()
}
