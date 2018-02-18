//
//  Authentication.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseAuth

enum LoginError: Error {
    case unknown
}

protocol AuthenticationProtocol {
    func login(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void)
    func signup(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void)
}

class Authentication: AuthenticationProtocol {

    func login(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let user = user {
                handler(.success(user))
            } else {
                handler(.error(.unknown))
            }
        }
    }

    func signup(email: String, password: String, handler: @escaping (Result<User, LoginError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let user = user {
                handler(.success(user))
            } else {
                handler(.error(.unknown))
            }
        }
    }

    // TODO: 非同期処理を同期処理に変えたかったけどうまくいかなかった
    //    func login(email: String, password: String) -> Result<User, LoginError> {
    //
    //        let semaphore = DispatchSemaphore(value: 0)
    //        var result: Result<User, LoginError> = .error(.unknown)
    //        let queue = DispatchQueue.global(qos: .default)
    //        queue.sync {
    //            print("🌟")
    //            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
    //                print("🍎") // ここに到達しないので一旦断念
    //                if let user = user {
    //                    result = .success(user)
    //                } else {
    //                    result = .error(.unknown) // とりあえず
    //                }
    //                semaphore.signal()
    //            }
    //        }
    //        semaphore.wait()
    //        return result
    //    }
}
