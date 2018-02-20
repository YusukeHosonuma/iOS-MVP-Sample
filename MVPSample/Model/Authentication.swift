//
//  Authentication.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import FirebaseAuth
import Foundation
import Promises

enum LoginError: Error {
    case unknown
}

protocol AuthenticationProtocol {
    func login(email: String, password: String) -> Promise<User>
    func signup(email: String, password: String) -> Promise<User>
}

// TODO: ちゃんとエラードメインを変換してあげた方がよい
class Authentication: AuthenticationProtocol {
    func login(email: String, password: String) -> Promise<User> {
        return Promise<User>(on: .main) { fulfill, reject in
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if let user = user {
                    fulfill(user)
                } else {
                    reject(error!)
                }
            }
        }
    }

    func signup(email: String, password: String) -> Promise<User> {
        return Promise<User>(on: .main) { fulfill, reject in
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if let user = user {
                    fulfill(user)
                } else {
                    reject(error!)
                }
            }
        }
    }
}
