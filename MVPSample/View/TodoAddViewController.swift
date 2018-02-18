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
    
    var presenter: TodoAddPresenter!
    
    var todo: Todo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TodoAddPresenter(view: self, todo: self.todo, todoList: appContext.todoList)
    }

    // MARK: - Action
    
    @IBAction func tapAddButton(_ sender: Any) {
        self.presenter.tapAddButton()
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
        self.presenter.tapDoneButton()
    }
}

extension TodoAddViewController: TodoAddViewProtocol {
    
    var titleText: String {
        get {
            return self.titleTextField.text!
        }
        set {
            self.titleTextField.text! = newValue
        }
    }

    func moveBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
