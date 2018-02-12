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
    var todos: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.presenter = TodoListPresenter(view: self)
        self.presenter.listen()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let todo = self.todos?[indexPath.row] else { return cell }
        cell.textLabel?.text = todo
        return cell
    }
}

extension TodoListViewController: TodoListViewProtocol {
    func showList(todos: [String]) {
        self.todos = todos
        self.tableView.reloadData()
    }
}

protocol TodoListViewProtocol: LoadingViewProtocol {
    func showList(todos: [String])
}

class TodoListPresenter {
    
    let view: TodoListViewProtocol
    let refTodo: DatabaseReference

    init(view: TodoListViewProtocol) {
        self.view = view
        self.refTodo = Database.database().reference().child("todo")
    }
    
    func listen() {
        self.view.showLoading()
        self.refTodo.observe(DataEventType.value) { (snapshot) in
            self.view.hideLoading()
            guard let todoDic = snapshot.value as? [String: [String: String]] else { return }
            let titles = todoDic.values.map { $0["title"]! }
            self.view.showList(todos: titles)
        }
    }
}
