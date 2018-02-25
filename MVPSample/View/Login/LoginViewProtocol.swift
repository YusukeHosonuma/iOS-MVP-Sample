//
//  LoginViewProtocol.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/24.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

enum LoginViewNavigation {
    case list
}

protocol LoginViewProtocol {
    var email: String { get set }
    var password: String { get set }

    func showLoading(message: String?)
    func hideLoading()

    func move(to: LoginViewNavigation)
    func showLoginError(message: String)
    func showSignupError(message: String)
    func showSignupSuccessDialog()
}
