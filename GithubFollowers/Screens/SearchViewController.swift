//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-21.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = GFImageView(named: Images.ghLogo)
    let usernameTextField = GFTextField()
    let followersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        dismissKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func layout() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(followersButton)
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
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
        
        usernameTextField.delegate = self
        followersButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)
        
    }
    
    func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListViewController() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter an username. We need to know who to look for 😄", button: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListViewController = FollowerListViewController(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListViewController()
        return true
    }
}
