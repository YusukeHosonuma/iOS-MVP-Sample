//
//  LoginViewController.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/12.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

// TODO: ログイン状態を維持したい
class LoginViewController: UIViewController {

    var presenter: LoginPresenter!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LoginPresenter(view: self, model: Authentication())
    }
    
    // MARK: - Action
    
    @IBAction func tapLoginButton(_ sender: Any) {
        guard
            let email = self.emailText.text,
            let password = self.passwordText.text else { return }
        self.presenter.tapLogin(email: email, password: password)
    }
    
    @IBAction func tapSignupButton(_ sender: Any) {
        guard
            let email = self.emailText.text,
            let password = self.passwordText.text else { return }
        self.presenter.tapSignup(email: email, password: password)
    }
}

extension LoginViewController: LoginViewProtocol {

    func toList() {
        self.performSegue(withIdentifier: R.segue.loginViewController.toList, sender: nil)
    }

    func showLoginError() {
        let alert = UIAlertController(title: "エラー", message: "ログインに失敗しました。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSignupError() {
        let alert = UIAlertController(title: "エラー", message: "サインアップに失敗しました。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showSignupSuccessDialog() {
        // TODO: メールアドレス認証を必須にしたい
        let alert = UIAlertController(title: "新規登録完了",
                                      message: "ログインを行ってください。",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

