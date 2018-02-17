//
//  TodoList.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseDatabase

// TODO: Todoというドメインは欲しい

class TodoList {

    var todoRef: DatabaseReference = Database.database().reference().child("todo")

    func add(title: String) {
        let value = ["title": title]
        self.todoRef.childByAutoId().setValue(value)
    }
    
    func observe(f: @escaping ([String]) -> ()) {
        self.todoRef.observe(DataEventType.value) { (snapshot) in
            let titles = snapshot.childrenDictionary().map { $0["title"] ?? "" }
            f(titles)
        }
    }
}
