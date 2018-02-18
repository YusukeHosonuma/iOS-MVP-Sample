//
//  TodoList.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

class TodoList {

    var todoRef: DatabaseReference = Database.database().reference().child("todo")

    func add(todo: Todo) {
        self.todoRef.childByAutoId().setValue(todo.firebaseValue)
    }
    
    func update(_ todo: Todo) {
        guard let key = todo.key else { preconditionFailure() }
        self.todoRef.child(key).setValue(todo.firebaseValue)
    }
    
    func observe(f: @escaping ([Todo]) -> ()) {
        self.todoRef.listen(.value, type: Todo.self) { todos in
            let xs: [Todo] = todos.map { (key, value) in
                return Todo(key: key, title: value.title, done: value.done)
            }
            f(xs)
        }
    }
}
