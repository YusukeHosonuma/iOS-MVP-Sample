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

// TODO: ちゃんとエラードメインを変換してあげた方がよい
class Authentication: AuthenticationProtocol {
    func isLogin() -> Bool {
        return Auth.auth().currentUser != nil
    }

    func login(email: String, password: String) -> Promise<MVPUser> {
        return Promise<MVPUser>(on: .main) { fulfill, reject in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let user = result?.user {
                    fulfill(MVPUser(user))
                } else {
                    reject(error!)
                }
            }
        }
    }

    func logout() -> Bool {
        do {
            try Auth.auth().signOut()
        } catch {
            return false
        }
        return true
    }

    func signup(email: String, password: String) -> Promise<MVPUser> {
        return Promise<MVPUser>(on: .main) { fulfill, reject in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let user = result?.user {
                    fulfill(MVPUser(user))
                } else {
                    reject(error!)
                }
            }
        }
    }
}
