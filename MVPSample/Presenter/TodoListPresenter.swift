//
//  TodoListPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import FirebaseDatabase
import Foundation

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
        view.moveToAdd()
    }

    func selectRow(at index: Int) {
        let todo = view.todo(at: index)
        view.moveToEdit(todo)
    }

    func listen() {
        view.showLoading(message: nil)
        todoList.observe { todos in
            self.view.hideLoading()
            self.view.showList(todos: todos)
        }
    }
}
