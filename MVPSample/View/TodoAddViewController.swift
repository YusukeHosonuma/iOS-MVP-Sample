//
//  TodoAddViewController.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/13.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import FirebaseDatabase
import UIKit

class TodoAddViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!

    var presenter: TodoAddPresenter!

    var todo: Todo?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TodoAddPresenter(view: self, todo: todo, todoList: appContext.todoList)
    }

    // MARK: - Action

    @IBAction func tapAddButton(_: Any) {
        presenter.tapAddButton()
    }

    @IBAction func tapDoneButton(_: Any) {
        presenter.tapDoneButton()
    }
}

extension TodoAddViewController: TodoAddViewProtocol {
    var titleText: String {
        get {
            return titleTextField.text!
        }
        set {
            titleTextField.text! = newValue
        }
    }

    func moveBack() {
        dismiss(animated: true, completion: nil)
    }
}
