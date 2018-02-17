//
//  TodoListPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol TodoListViewProtocol: LoadingViewProtocol {
    func showList(todos: [String])
    func moveToAdd()
}

class TodoListPresenter {
    
    let view: TodoListViewProtocol
    let refTodo: DatabaseReference
    
    init(view: TodoListViewProtocol) {
        self.view = view
        self.refTodo = Database.database().reference().child("todo")
    }
    
    func add() {
        self.view.moveToAdd()
    }
    
    func listen() {
        self.view.showLoading(message: nil)
        // TODO: Modelとして切り出す
        self.refTodo.observe(DataEventType.value) { (snapshot) in
            self.view.hideLoading()
            let titles = snapshot.childrenDictionary().map { $0["title"] ?? "" }
            self.view.showList(todos: titles)
        }
    }
}
