//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-22.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 10
        layer.borderWidth                           = 2
        layer.borderColor                           = UIColor.systemGray4.cgColor
        
        adjustsFontSizeToFitWidth                   = true
        minimumFontSize                             = 12
        textAlignment                               = .center
        textColor                                   = .label
        tintColor                                   = .label
        font                                        = UIFont.preferredFont(forTextStyle: .title2)
        
        autocorrectionType                          = .no
        backgroundColor                             = .tertiarySystemBackground
        clearButtonMode                             = .whileEditing
        returnKeyType                               = .go
        placeholder                                 = "Enter a username"
    }
}
