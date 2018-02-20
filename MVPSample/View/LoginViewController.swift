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

// TODO: ログイン状態を維持したい
class LoginViewController: UIViewController {
    var presenter: LoginPresenter!

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self, auth: appContext.authentication)
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
        return emailText.text ?? ""
    }

    var password: String {
        return passwordText.text ?? ""
    }

    func toList() {
        performSegue(withIdentifier: R.segue.loginViewController.toList, sender: nil)
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
