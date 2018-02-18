//
//  LoginPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: LoadingViewProtocol {
    func toList()
    func showLoginError()
    func showSignupError()
    func showSignupSuccessDialog()
}

class LoginPresenter {
    let view: LoginViewProtocol
    let model: AuthenticationProtocol

    init(view: LoginViewProtocol, model: AuthenticationProtocol) {
        self.view = view
        self.model = model
    }

    func tapLogin(email: String, password: String) {
        view.showLoading(message: "ログイン中")
        model.login(email: email, password: password) { result in
            self.view.hideLoading()
            switch result {
            case .success:
                self.view.toList()
            case .error:
                self.view.showLoginError()
            }
        }
    }

    func tapSignup(email: String, password: String) {
        view.showLoading(message: "サインアップ中")
        model.signup(email: email, password: password) { result in
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
