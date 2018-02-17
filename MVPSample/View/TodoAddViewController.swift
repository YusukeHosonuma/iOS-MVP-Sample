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

    @IBOutlet weak var titleTextField: UITextField!
    
    var ref: DatabaseReference!
    var presenter: TodoAddPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.presenter = TodoAddPresenter(view: self, todoList: TodoList()) // TODO: Singletonにすべきかも
    }

    // MARK: - Action
    
    @IBAction func tapAddButton(_ sender: Any) {
        self.presenter.tapAddButton()
        self.dismiss(animated: true, completion: nil)
    }
}

extension TodoAddViewController: TodoAddViewProtocol {
    
    var titleText: String {
        return self.titleTextField.text!
    }
}
