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

//
// View
//

class LoginViewController: UIViewController {

    var presenter: LoginPresenter!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LoginPresenter(view: self, model: LoginModel())
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
        self.performSegue(withIdentifier: "toList", sender: nil)
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

//
// Presenter
//

protocol LoginViewProtocol: LoadingViewProtocol {
    func toList()
    func showLoginError()
    func showSignupError()
    func showSignupSuccessDialog()
}

class LoginPresenter {
    
    let view: LoginViewProtocol
    let model: LoginModelProtocol
    
    init(view: LoginViewProtocol, model: LoginModelProtocol) {
        self.view = view
        self.model = model
    }
    
    func tapLogin(email: String, password: String) {
        self.view.showLoading(message: "ログイン中")
        self.model.login(email: email, password: password) { result in
            self.view.hideLoading()
            switch result {
            case .success(_):
                self.view.toList()
            case .error(_):
                self.view.showLoginError()
            }
        }
    }
    
    func tapSignup(email: String, password: String) {
        self.view.showLoading(message: "サインアップ中")
        self.model.signup(email: email, password: password) { (result) in
            self.view.hideLoading()
            switch result {
            case .success(_):
                self.view.showSignupSuccessDialog()
            case .error(_):
                self.view.showSignupError()
            }
        }
    }
}

//
// Model
//

enum Result<T, E: Error> {
    case success(T)
    case error(E)
}

enum LoginError: Error {
    case unknown
}

protocol LoginModelProtocol {
    func login(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void)
    func signup(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void)
}

class LoginModel: LoginModelProtocol {
    
    func login(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let user = user {
                handler(.success(user))
            } else {
                handler(.error(.unknown))
            }
        }
    }
    
    func signup(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let user = user {
                handler(.success(user))
            } else {
                handler(.error(.unknown))
            }
        }
    }

    // TODO: 非同期処理を同期処理に変えたかったけどうまくいかなかった
//    func login(email: String, password: String) -> Result<User, LoginError> {
//
//        let semaphore = DispatchSemaphore(value: 0)
//        var result: Result<User, LoginError> = .error(.unknown)
//        let queue = DispatchQueue.global(qos: .default)
//        queue.sync {
//            print("🌟")
//            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//                print("🍎") // ここに到達しないので一旦断念
//                if let user = user {
//                    result = .success(user)
//                } else {
//                    result = .error(.unknown) // とりあえず
//                }
//                semaphore.signal()
//            }
//        }
//        semaphore.wait()
//        return result
//    }
}

