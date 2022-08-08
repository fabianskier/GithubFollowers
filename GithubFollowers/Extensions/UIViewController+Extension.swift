//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-23.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, button: String) {
        DispatchQueue.main.async {
            let alertViewController                     = GFAlertViewController(title: title, message: message, button: button)
            alertViewController.modalPresentationStyle  = .overFullScreen
            alertViewController.modalTransitionStyle    = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
    
    func presentGFAlert(title: String, message: String, button: String) {
        let alertViewController                     = GFAlertViewController(title: title, message: message, button: button)
        alertViewController.modalPresentationStyle  = .overFullScreen
        alertViewController.modalTransitionStyle    = .crossDissolve
        self.present(alertViewController, animated: true)
    }
    
    func presentDefaultGFAlert(title: String = "Something wen wrong",
                               message: String = "We are unable to complete your task at this time. Please try again.",
                               button: String = "Ok") {
        let alertViewController                     = GFAlertViewController(title: title, message: message, button: button)
        alertViewController.modalPresentationStyle  = .overFullScreen
        alertViewController.modalTransitionStyle    = .crossDissolve
        self.present(alertViewController, animated: true)
    }
    
    func presentSafariViewController(with url: URL) {
        let safariViewController                        = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor  = .systemGreen
        present(safariViewController, animated: true)
    }
}
