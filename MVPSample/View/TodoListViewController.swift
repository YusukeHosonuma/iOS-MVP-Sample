//
//  TodoListViewController.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/12.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TodoListPresenter!
    var todos: [Todo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.presenter = TodoListPresenter(view: self, todoList: TodoList()) // TODO: Singletonに
        self.presenter.listen()
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
        let cell = UITableViewCell()
        guard let todo = self.todos?[indexPath.row] else { return cell }
        cell.textLabel?.text = todo.title
        // TODO: 完了マーク
        return cell
    }
    
    // TODO: 編集機能も欲しい
}

extension TodoListViewController: TodoListViewProtocol {
    
    func showList(todos: [Todo]) {
        self.todos = todos
        self.tableView.reloadData()
    }
    
    func moveToAdd() {
        self.performSegue(withIdentifier: "toAdd", sender: nil)
    }
}

