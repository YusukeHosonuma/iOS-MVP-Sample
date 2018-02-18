//
//  LoginPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: LoadingViewProtocol {
    var email: String { get }
    var password: String { get }

    func toList()
    func showLoginError()
    func showSignupError()
    func showSignupSuccessDialog()
}

class LoginPresenter {
    let view: LoginViewProtocol
    let authentication: AuthenticationProtocol

    init(view: LoginViewProtocol, model: AuthenticationProtocol) {
        self.view = view
        self.authentication = model
    }

    func tapLoginButton() {
        view.showLoading(message: "ログイン中")
        authentication.login(email: view.email, password: view.password) { result in
            self.view.hideLoading()
            switch result {
            case .success:
                self.view.toList()
            case .error:
                self.view.showLoginError()
            }
        }
    }

    func tapSignupButton() {
        view.showLoading(message: "サインアップ中")
        authentication.signup(email: view.email, password: view.password) { result in
            self.view.hideLoading()
            switch result {
            case .success:
                self.view.showSignupSuccessDialog()
            case .error:
                self.view.showSignupError()
            }
        }
    }
}

