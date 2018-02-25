//
//  LoginPresenterTests.swift
//  MVPSampleTests
//
//  Created by Yusuke Hosonuma on 2018/02/21.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import FirebaseAuth
@testable import MVPSample
import Promises
import XCTest

class LoginPresenterTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_tapLoginButton_success() {
        //
        // Given
        //
        let view = LoginViewMock("username", "password")
        view.hideLoadingExpectation = expectation(description: "")
        let auth = AuthMock(success: true)
        let presenter = LoginPresenter(view: view, auth: auth)

        //
        // When
        //
        presenter.tapLoginButton()
        waitForExpectations(timeout: 3, handler: nil)

        //
        // Then
        //
        XCTAssertTrue(view.showLoading_)
        XCTAssertTrue(view.hideLoading_)
        XCTAssertTrue(view.toList_)
    }

    func test_tapLoginButton_failed() {
        //
        // Given
        //
        let view = LoginViewMock("username", "password")
        view.hideLoadingExpectation = expectation(description: "")
        let auth = AuthMock(success: false)
        let presenter = LoginPresenter(view: view, auth: auth)

        //
        // When
        //
        presenter.tapLoginButton()
        waitForExpectations(timeout: 3, handler: nil)

        //
        // Then
        //
        XCTAssertTrue(view.showLoading_)
        XCTAssertTrue(view.hideLoading_)
        XCTAssertTrue(view.showLoginError_)
    }

    // TODO: signupのテストも追加する
}

class LoginViewMock: LoginViewProtocol {
    var email: String
    var password: String

    var toList_ = false
    var showLoginError_ = false
    var showSignupError_ = false
    var showSignupSuccessDialog_ = false
    var showLoading_ = false
    var hideLoading_ = false

    var hideLoadingExpectation: XCTestExpectation?

    init(_ email: String, _ password: String) {
        self.email = email
        self.password = password
    }

    func move() {
        toList_ = true
    }

    func showLoginError(message _: String) {
        showLoginError_ = true
    }

    func showSignupError(message _: String) {
        showSignupError_ = true
    }

    func showSignupSuccessDialog() {
        showSignupSuccessDialog_ = true
    }

    func showLoading(message _: String?) {
        showLoading_ = true
    }

    func hideLoading() {
        hideLoading_ = true
        hideLoadingExpectation?.fulfill()
    }
}

class AuthMock: AuthenticationProtocol {
    let success: Bool

    init(success: Bool) {
        self.success = success
    }

    func login(email _: String, password _: String) -> Promise<MVPUser> {
        return Promise<MVPUser> {
            guard self.success else { throw LoginError.unknown }
            return MVPUser(displayName: "alice", email: "password")
        }
    }

    func signup(email _: String, password _: String) -> Promise<MVPUser> {
        return Promise<MVPUser> {
            MVPUser(displayName: "alice", email: "password")
        }
    }
}
