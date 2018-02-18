//
//  Firebase+.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CodableFirebase

struct FirebaseModel<T> {
    let key: String
    let value: T
}

extension DatabaseReference {
    func listen<T: Codable>(_ event: DataEventType, type: T.Type, callback: @escaping ([FirebaseModel<T>]) -> ()) {
        self.observe(event) { (snapshot) in
            let items = snapshot.items(type)
            callback(items)
        }
    }
}

extension DataSnapshot {
    func items<T: Codable>(_ type: T.Type) -> [FirebaseModel<T>] {
        var xs = [FirebaseModel<T>]()
        for child in self.children {
            let snapshot = child as! DataSnapshot
            do {
                let value = try FirebaseDecoder().decode(type, from: snapshot.value!)
                xs.append(FirebaseModel(key: snapshot.key, value: value))
            } catch let error {
                print(error) // TODO: KVS構造の変更には弱い（トレードオフ）
            }
        }
        return xs
    }
}
