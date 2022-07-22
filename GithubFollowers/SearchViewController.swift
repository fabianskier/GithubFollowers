//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-21.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = GFImageView(named: "gh-logo")
    let usernameTextField = GFTextField()
    let followersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    func layout() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(followersButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            followersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            followersButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            followersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            followersButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
