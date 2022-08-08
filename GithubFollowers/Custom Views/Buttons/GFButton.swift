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
    
    convenience init(color: UIColor, title: String, systemImageName: String, state: UIControl.State = .normal) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    private func configure() {
        configuration                               = .tinted()
        configuration?.cornerStyle                  = .medium
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor  = color
        configuration?.baseForegroundColor  = color
        configuration?.title                = title
        configuration?.image                = UIImage(systemName: systemImageName)
        configuration?.imagePadding         = 6
        configuration?.imagePlacement       = .leading
    }
}
