//
//  TodoListViewController.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/12.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TodoListCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

extension TodoListCell {
    func apply(_ todo: Todo) {
        self.titleLabel?.text = todo.title
        self.accessoryType = todo.done ? .checkmark : .none
    }
}

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TodoListPresenter!
    var todos: [Todo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.presenter = TodoListPresenter(view: self, todoList: appContext.todoList)
        self.presenter.listen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let info = R.segue.todoListViewController.toAdd(segue: segue) else { return }
        if let todo = sender as? Todo {
            info.destination.todo = todo
        }
    }
    
    // MARK: - Action
    
    @IBAction func tapAddButton(_ sender: Any) {
        self.presenter.add()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TodoListCell else { preconditionFailure() }
        guard let todo = self.todos?[indexPath.row] else { return cell }
        cell.apply(todo)
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.selectRow(at: indexPath.row)
    }
}

extension TodoListViewController: TodoListViewProtocol {
    
    func todo(at index: Int) -> Todo {
        guard let todo = self.todos?[index] else { preconditionFailure() }
        return todo
    }
    
    func showList(todos: [Todo]) {
        self.todos = todos
        self.tableView.reloadData()
    }
    
    func moveToAdd() {
        self.performSegue(withIdentifier: R.segue.todoListViewController.toAdd, sender: nil)
    }
    
    func moveToEdit(_ todo: Todo) {
        self.performSegue(withIdentifier: R.segue.todoListViewController.toAdd, sender: todo)
    }
}
