//
//  AuthenticationProtocol.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/24.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import Promises

protocol AuthenticationProtocol {
    func login(email: String, password: String) -> Promise<MVPUser>
    func signup(email: String, password: String) -> Promise<MVPUser>
}
