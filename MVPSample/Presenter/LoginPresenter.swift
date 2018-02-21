//
//  LoginPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import Promises

protocol LoginViewProtocol: LoadingViewProtocol {
    var email: String { get set }
    var password: String { get set }

    func toList()
    func showLoginError(message: String)
    func showSignupError(message: String)
    func showSignupSuccessDialog()
}

class LoginPresenter {
    var view: LoginViewProtocol
    let auth: AuthenticationProtocol

    init(view: LoginViewProtocol, auth: AuthenticationProtocol) {
        self.view = view
        self.auth = auth
    }

    func tapLoginButton() {
        view.showLoading(message: "ログイン中")
        auth.login(email: view.email, password: view.password).then { _ in
            self.view.email = ""
            self.view.password = ""
            self.view.toList()
        }.catch { error in
            self.view.showLoginError(message: error.localizedDescription)
        }.always {
            self.view.hideLoading()
        }
    }

    func tapSignupButton() {
        view.showLoading(message: "サインアップ中")
        auth.signup(email: view.email, password: view.password).then { _ in
            self.view.showSignupSuccessDialog()
        }.catch { error in
            self.view.showSignupError(message: error.localizedDescription)
        }.always {
            self.view.hideLoading()
        }
    }
}
