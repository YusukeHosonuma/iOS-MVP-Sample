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
    
    func observe(f: @escaping ([Todo]) -> ()) {
        self.todoRef.observe(DataEventType.value) { (snapshot) in
            let xs: [Todo] = snapshot.childrenDictionary().map {
                // TODO: Codableを使いたい
                let title = $0["title"] ?? ""
                let done  = $0["done"].flatMap { Bool($0) } ?? false
                return Todo(title: title, done: done)
            }
            f(xs)
        }
    }
}
