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
    let todoList: TodoList
    
    init(view: TodoListViewProtocol, todoList: TodoList) {
        self.view = view
        self.todoList = todoList
    }
    
    func add() {
        self.view.moveToAdd()
    }
    
    func listen() {
        self.view.showLoading(message: nil)
        self.todoList.observe { todos in
            self.view.hideLoading()
            self.view.showList(todos: todos)
        }
    }
}
