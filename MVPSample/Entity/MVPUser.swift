//
//  MVPUser.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/21.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import FirebaseAuth
import Foundation

struct MVPUser {
    let displayName: String
    let email: String
}

extension MVPUser {
    init(_ user: FirebaseAuth.User) {
        displayName = user.displayName ?? ""
        email = user.email ?? ""
    }
}
