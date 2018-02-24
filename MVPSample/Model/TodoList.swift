//
//  TodoList.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import CodableFirebase
import FirebaseDatabase
import Foundation

class TodoList {
    private var todoRef: DatabaseReference = Database.database().reference().child("todo")

    private var latest: [Todo] = []

    func fetchWith(query: String) -> [Todo] {
        return query.isEmpty
            ? latest
            : latest.filter { $0.isMatch(query) }
    }

    func add(todo: Todo) {
        todoRef.childByAutoId().setValue(todo.firebaseValue)
    }

    func update(_ todo: Todo) {
        guard let key = todo.key else { preconditionFailure() }
        todoRef.child(key).setValue(todo.firebaseValue)
    }

    func observe(f: @escaping ([Todo]) -> Void) {
        todoRef.listen(.value, type: Todo.self) { model in
            let xs: [Todo] = model.map {
                let key = $0.key
                let value = $0.value
                return Todo(key: key, title: value.title, done: value.done)
            }
            self.latest = xs
            f(xs)
        }
    }
}
