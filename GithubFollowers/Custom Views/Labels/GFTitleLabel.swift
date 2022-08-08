//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-22.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight = .bold) {
        self.init(frame: .zero)
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.9
        lineBreakMode                               = .byTruncatingTail
        textColor                                   = .label
    }

}
