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
        show()
    }

    private func show() {
        if let title = self.todo?.title {
            view.titleText = title
        }
    }

    // TODO: validation

    func tapAddButton() {
        let todo = Todo.new(title: view.titleText)
        todoList.add(todo: todo)
        view.moveBack()
    }

    func tapDoneButton() {
        guard var todo = self.todo else { preconditionFailure() }
        todo.title = view.titleText
        todo.done = true
        todoList.update(todo)
        view.moveBack()
    }
}
