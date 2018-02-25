//
//  TodoListViewController.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/12.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import FirebaseDatabase
import UIKit

class TodoListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
}

extension TodoListCell {
    func apply(_ todo: Todo) {
        titleLabel?.text = todo.title
        accessoryType = todo.done ? .checkmark : .none
    }
}

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!

    @IBOutlet var searchBar: UISearchBar!
    var presenter: TodoListPresenter!
    var todos: [Todo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        presenter = TodoListPresenter(view: self, todoList: appContext.todoList, auth: appContext.authentication)
        presenter.listen()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let info = R.segue.todoListViewController.toAdd(segue: segue) else { return }
        if let todo = sender as? Todo {
            info.destination.todo = todo
        }
    }

    // MARK: - Action

    @IBAction func tapLogoutButton(_: Any) {
        presenter.tapLogoutButton()
    }

    @IBAction func tapAddButton(_: Any) {
        presenter.tapAddButton()
    }

    // MARK: - UITableViewDataSource

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return todos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell, for: indexPath)!
        guard let todo = self.todos?[indexPath.row] else { return cell }
        cell.apply(todo)
        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectRow(at: indexPath.row)
    }

    // MARK: UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange _: String) {
        guard let text = searchBar.text else { preconditionFailure() }
        presenter.didChangeSearchText(text)
    }
}

extension TodoListViewController: TodoListViewProtocol {
    func move(to: TodoListViewNavigation) {
        switch to {
        case .back:
            dismiss(animated: true, completion: nil)
        case .add:
            performSegue(withIdentifier: R.segue.todoListViewController.toAdd, sender: nil)
        case let .edit(todo):
            performSegue(withIdentifier: R.segue.todoListViewController.toAdd, sender: todo)
        }
    }

    func todo(at index: Int) -> Todo {
        guard let todo = self.todos?[index] else { preconditionFailure() }
        return todo
    }

    func showList(todos: [Todo]) {
        self.todos = todos
        tableView.reloadData()
    }

    func showLogoutErrorDialog(message: String) {
        AlertBuilder()
            .title("ログアウト")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }
}
