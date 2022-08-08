//
//  GFImageView.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-22.
//

import UIKit

class GFImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(named: String) {
        super.init(frame: .zero)
        image = UIImage(named: named)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
