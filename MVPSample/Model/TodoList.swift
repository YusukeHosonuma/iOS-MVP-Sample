//
//  TodoList.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseDatabase

class TodoList {

    var todoRef: DatabaseReference = Database.database().reference().child("todo")

    func add(todo: Todo) {
        let value = ["title": todo.title]
        self.todoRef.childByAutoId().setValue(value)
    }
    
    func update(_ todo: Todo) {
        guard let key = todo.key else { preconditionFailure() }
        let value: [String: Any] = [
            "title": todo.title,
            "done" : todo.done
            ]
        self.todoRef.child(key).setValue(value)
    }
    
    func observe(f: @escaping ([Todo]) -> ()) {
        self.todoRef.observe(DataEventType.value) { (snapshot) in
            let xs: [Todo] = snapshot.childrenDictionary().map { (key, value) in
                // TODO: Codableを使いたい
                let title = value["title"] as? String ?? ""
                let done  = value["done"]  as? Bool   ?? false
                return Todo(key: key, title: title, done: done)
            }
            f(xs)
        }
    }
}
