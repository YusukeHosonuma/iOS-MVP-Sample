//
//  LoginPresenter.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import Promises

class LoginPresenter {
    var view: LoginViewProtocol
    let auth: AuthenticationProtocol

    init(view: LoginViewProtocol, auth: AuthenticationProtocol) {
        self.view = view
        self.auth = auth
    }

    func show() {
        if auth.isLogin() {
            view.move(to: .list)
        }
    }

    func tapLoginButton() {
        view.showLoading(message: "ログイン中")
        auth.login(email: view.email, password: view.password).then { _ in
            self.view.email = ""
            self.view.password = ""
            self.view.move(to: .list)
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
