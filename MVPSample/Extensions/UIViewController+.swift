//
//  UIViewController+.swift
//  MVPSample
//
//  Created by Yusuke on 2018/02/12.
//  Copyright © 2018 Yusuke. All rights reserved.
//

import Foundation
import SVProgressHUD
import UIKit

protocol LoadingViewProtocol {
    func showLoading(message: String?)
    func hideLoading()
}

extension UIViewController: LoadingViewProtocol {
    func showLoading(message: String?) {
        SVProgressHUD.show(withStatus: message)
    }

    func hideLoading() {
        SVProgressHUD.dismiss()
    }
}
