//
//  AlertBuilder.swift
//  MVPSample
//
//  Created by Yusuke Hosonuma on 2018/02/20.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import UIKit

final class AlertBuilder {
    typealias Builder = AlertBuilder

    private var title_: String?
    private var message_: String?
    private var actions_: [UIAlertAction] = []

    static func builder() -> Builder {
        return Builder()
    }

    func title(_ text: String) -> Builder {
        title_ = text
        return self
    }

    func message(_ text: String) -> Builder {
        message_ = text
        return self
    }

    func action(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Builder {
        actions_.append(UIAlertAction(title: title, style: .default, handler: handler))
        return self
    }

    func build() -> UIAlertController {
        let alert = UIAlertController(title: title_, message: message_, preferredStyle: .alert)
        for action in actions_ {
            alert.addAction(action)
        }
        return alert
    }

    func show(_ viewController: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        viewController.present(build(), animated: animated, completion: completion)
    }
}
