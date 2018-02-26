//
//  LoginViewController.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/12.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {
    var presenter: LoginPresenter!

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self, auth: appContext.authentication)
        presenter.show()
    }

    // MARK: - Action

    @IBAction func tapLoginButton(_: Any) {
        presenter.tapLoginButton()
    }

    @IBAction func tapSignupButton(_: Any) {
        presenter.tapSignupButton()
    }
}

extension LoginViewController: LoginViewProtocol {
    var email: String {
        get { return emailText.text ?? "" }
        set { emailText.text = newValue }
    }

    var password: String {
        get { return passwordText.text ?? "" }
        set { passwordText.text = newValue }
    }

    func move(to: LoginViewNavigation) {
        switch to {
        case .list:
            performSegue(withIdentifier: R.segue.loginViewController.toList, sender: nil)
        }
    }

    func showLoginError(message: String) {
        AlertBuilder()
            .title("ログインに失敗しました。")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }

    func showSignupError(message: String) {
        AlertBuilder()
            .title("サインアップに失敗しました。")
            .message(message)
            .action("OK")
            .show(self, animated: true)
    }

    func showSignupSuccessDialog() {
        // TODO: メールアドレス認証を必須にしたい
        AlertBuilder()
            .title("新規登録完了")
            .message("ログインを行ってください。")
            .action("OK")
            .show(self, animated: true)
    }
}
