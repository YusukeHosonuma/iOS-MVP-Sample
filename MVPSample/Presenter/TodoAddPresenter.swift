//
//  TodoAddPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

protocol TodoAddViewProtocol {
    var titleText: String { get set }
    func moveBack()
}

class TodoAddPresenter {
    
    var view: TodoAddViewProtocol
    let todo: Todo?
    let todoList: TodoList
    
    init(view: TodoAddViewProtocol, todo: Todo?, todoList: TodoList) {
        self.view = view
        self.todo = todo
        self.todoList = todoList
        self.show()
    }
    
    private func show() {
        if let title = self.todo?.title {
            self.view.titleText = title
        }
    }
    
    // TODO: validation
    
    func tapAddButton() {
        let todo = Todo.new(title: self.view.titleText)
        self.todoList.add(todo: todo)
        self.view.moveBack()
    }
    
    func tapDoneButton() {
        guard var todo = self.todo else { preconditionFailure() }
        todo.title = self.view.titleText
        todo.done  = true
        self.todoList.update(todo)
        self.view.moveBack()
    }
}
