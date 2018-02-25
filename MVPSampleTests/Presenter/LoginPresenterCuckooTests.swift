//
//  LoginPresenterCuckooTests.swift
//  MVPSampleTests
//
//  Created by Yusuke Hosonuma on 2018/02/24.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Cuckoo
import FirebaseAuth
@testable import MVPSample
import Promises
import XCTest

class LoginPresenterCuckooTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_tapLoginButton_success_with_cuckoo() {
        //
        // Given
        //
        let view = MockLoginViewProtocol()
        let exp = expectation(description: "")
        stub(view) { stub in
            when(stub.email.get).thenReturn("email")
            when(stub.password.get).thenReturn("password")
            when(stub.email.set(any())).thenDoNothing()
            when(stub.password.set(any())).thenDoNothing()
            when(stub.showLoading(message: any())).thenDoNothing()
            when(stub.toList()).thenDoNothing()
            when(stub.hideLoading()).then {
                exp.fulfill()
            }
        }

        let auth = MockAuthenticationProtocol()
        stub(auth) { stub in
            when(stub.login(email: any(), password: any())).thenReturn(Promise<MVPUser> {
                MVPUser(displayName: "alice", email: "password")
            })
        }

        let presenter = LoginPresenter(view: view, auth: auth)

        //
        // When
        //
        presenter.tapLoginButton()
        waitForExpectations(timeout: 3, handler: nil)

        //
        // Then
        //
        verify(view).showLoading(message: any())
        verify(view).hideLoading()
        verify(view).toList()
    }
}
