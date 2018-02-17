//
//  TodoAddViewController.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/13.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TodoAddViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    
    var ref: DatabaseReference!
    var presenter: TodoAddPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.presenter = TodoAddPresenter(todoList: TodoList()) // TODO: Singletonにすべきかも
    }

    // MARK: - Action
    
    @IBAction func tapAddButton(_ sender: Any) {
        guard let title = self.titleText.text else { preconditionFailure() }
        self.presenter.addTodo(title: title)
        self.dismiss(animated: true, completion: nil)
    }
}
