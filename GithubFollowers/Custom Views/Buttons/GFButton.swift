//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-21.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init(backgroundColor: UIColor, title: String, state: UIControl.State = .normal) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: state)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
        layer.cornerRadius                          = 10
        setTitleColor(.white, for: .normal)
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
