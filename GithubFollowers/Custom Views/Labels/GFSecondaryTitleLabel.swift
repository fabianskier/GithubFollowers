//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-29.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.90
        lineBreakMode                               = .byTruncatingTail
        textColor                                   = .secondaryLabel
    }

}
