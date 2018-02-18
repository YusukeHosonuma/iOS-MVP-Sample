//
//  Todo.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/18.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

struct Todo {
    let key: String?
    var title: String
    var done: Bool
}

extension Todo {
    static func new(title: String) -> Todo {
        return Todo(key: nil, title: title, done: false)
    }
}
