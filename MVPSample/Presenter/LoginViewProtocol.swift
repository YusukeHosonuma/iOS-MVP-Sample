//
//  LoginViewProtocol.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/24.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

protocol LoginViewProtocol {
    var email: String { get }
    var password: String { get }

    func showLoading(message: String?)
    func hideLoading()

    func toList()
    func showLoginError(message: String)
    func showSignupError(message: String)
    func showSignupSuccessDialog()
}
