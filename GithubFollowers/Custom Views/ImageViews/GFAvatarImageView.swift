//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage    = UIImage(named: "avatar-placeholder")
    let cache               = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 10
        clipsToBounds                               = true
        image                                       = placeholderImage
    }
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
