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
    func showList(todos: [Todo])
    func moveToAdd()
    func moveToEdit(_ todo: Todo)
    func todo(at index: Int) -> Todo
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

    func selectRow(at index: Int) {
        let todo = self.view.todo(at: index)
        self.view.moveToEdit(todo)
    }

    func listen() {
        self.view.showLoading(message: nil)
        self.todoList.observe { todos in
            self.view.hideLoading()
            self.view.showList(todos: todos)
        }
    }
}
