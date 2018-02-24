//
//  TodoListPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import FirebaseDatabase
import Foundation

// TODO: move系はまとめて種類をenumで表現したほうが良いかも
protocol TodoListViewProtocol: LoadingViewProtocol {
    func showList(todos: [Todo])
    func moveToBack()
    func moveToAdd()
    func moveToEdit(_ todo: Todo)
    func todo(at index: Int) -> Todo
    func showLogoutErrorDialog(message: String)
}

class TodoListPresenter {
    let view: TodoListViewProtocol
    let todoList: TodoList
    let auth: Authentication

    init(view: TodoListViewProtocol, todoList: TodoList, auth: Authentication) {
        self.view = view
        self.todoList = todoList
        self.auth = auth
    }

    func didChangeSearchText(_ query: String) {
        view.showList(todos: todoList.fetchWith(query: query))
    }

    func tapAddButton() {
        view.moveToAdd()
    }

    func tapLogoutButton() {
        if auth.logout() {
            view.moveToBack()
        } else {
            view.showLogoutErrorDialog(message: "ログアウトに失敗しました。")
        }
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
