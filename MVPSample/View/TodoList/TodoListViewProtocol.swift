//
//  TodoListViewProtocol.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/25.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

enum TodoListViewNavigation {
    case back
    case add
    case edit(Todo)
}

protocol TodoListViewProtocol {
    func move(to: TodoListViewNavigation)
    func showList(todos: [Todo])
    func todo(at index: Int) -> Todo
    func showLogoutErrorDialog(message: String)
    func showLoading(message: String?)
    func hideLoading()
}
