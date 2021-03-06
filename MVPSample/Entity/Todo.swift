//
//  Todo.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/18.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import CodableFirebase
import Foundation

struct Todo: Codable {
    var key: String?
    var title: String
    var done: Bool

    enum CodingKeys: String, CodingKey {
        case title
        case done
    }

    init(key: String?, title: String, done: Bool) {
        self.key = key
        self.title = title
        self.done = done
    }
}

extension Todo {
    static func new(title: String) -> Todo {
        return Todo(key: nil, title: title, done: false)
    }

    var firebaseValue: Any {
        return try! FirebaseEncoder().encode(self)
    }

    func isMatch(_ text: String) -> Bool {
        return title.localizedCaseInsensitiveContains(text)
    }
}
