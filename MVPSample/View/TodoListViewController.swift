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

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    var presenter: TodoListPresenter!
    var todos: [Todo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        presenter = TodoListPresenter(view: self, todoList: appContext.todoList)
        presenter.listen()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let info = R.segue.todoListViewController.toAdd(segue: segue) else { return }
        if let todo = sender as? Todo {
            info.destination.todo = todo
        }
    }

    // MARK: - Action

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
}

extension TodoListViewController: TodoListViewProtocol {
    func todo(at index: Int) -> Todo {
        guard let todo = self.todos?[index] else { preconditionFailure() }
        return todo
    }

    func showList(todos: [Todo]) {
        self.todos = todos
        tableView.reloadData()
    }

    func moveToAdd() {
        performSegue(withIdentifier: R.segue.todoListViewController.toAdd, sender: nil)
    }

    func moveToEdit(_ todo: Todo) {
        performSegue(withIdentifier: R.segue.todoListViewController.toAdd, sender: todo)
    }
}
