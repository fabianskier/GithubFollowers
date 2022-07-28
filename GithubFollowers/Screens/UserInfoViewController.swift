//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-28.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
