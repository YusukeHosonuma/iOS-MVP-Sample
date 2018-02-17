//
//  Result.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/17.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation

// TODO: ライブラリ使ってもいいかも
enum Result<T, E: Error> {
    case success(T)
    case error(E)
}
