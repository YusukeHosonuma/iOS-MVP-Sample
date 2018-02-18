//
//  Firebase+.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseDatabase

typealias FirebaseValue = (key: String, value: [String: Any])

extension DataSnapshot {
    func childrenDictionary() -> [FirebaseValue] {
        var items: [FirebaseValue] = []
        for child in self.children {
            let snapshot = child as! DataSnapshot
            let value = snapshot.value as! [String: Any]
            items.append(FirebaseValue(key: snapshot.key, value))
        }
        return items
    }
}
