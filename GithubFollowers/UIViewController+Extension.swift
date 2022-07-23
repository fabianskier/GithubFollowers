//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-23.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, button: String) {
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(title: title, message: message, button: button)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
}
