//
//  TodoListViewProtocol.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/25.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

enum Navigation {
    case back
    case add
    case edit(Todo)
}

protocol TodoListViewProtocol: LoadingViewProtocol {
    func move(to: Navigation)
    func showList(todos: [Todo])
    func todo(at index: Int) -> Todo
    func showLogoutErrorDialog(message: String)
}
