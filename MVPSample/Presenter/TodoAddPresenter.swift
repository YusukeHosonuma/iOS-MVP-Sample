//
//  TodoAddPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

protocol TodoAddViewProtocol {}

class TodoAddPresenter {
    
    let todoList: TodoList
    
    init(todoList: TodoList) {
        self.todoList = todoList
    }
    
    func addTodo(title: String) {
        self.todoList.add(title: title)
    }
}
