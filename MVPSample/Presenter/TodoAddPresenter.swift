//
//  TodoAddPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

protocol TodoAddViewProtocol {
    var titleText: String { get }
}

class TodoAddPresenter {
    
    let view: TodoAddViewProtocol
    let todoList: TodoList
    
    init(view: TodoAddViewProtocol, todoList: TodoList) {
        self.view = view
        self.todoList = todoList
    }
    
    func tapAddButton() {
        let todo = Todo(title: self.view.titleText, done: false)
        self.todoList.add(todo: todo)
    }
}
