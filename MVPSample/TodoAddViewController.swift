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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
    }

    // MARK: - Action
    
    @IBAction func tapAddButton(_ sender: Any) {
        guard let title = self.titleText.text else { return }
        self.ref.child("todo").childByAutoId().setValue(["title": title])
        self.dismiss(animated: true, completion: nil)
    }
}
// TODO: MVP化
