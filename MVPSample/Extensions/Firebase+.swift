//
//  Firebase+.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DataSnapshot {
    func childrenDictionary() -> [[String: String]] {
        var items: [[String: String]] = []
        for child in self.children {
            let snapshot = child as! DataSnapshot
            let dictionary = snapshot.value as! [String: String]
            items.append(dictionary)
        }
        return items
    }
}
