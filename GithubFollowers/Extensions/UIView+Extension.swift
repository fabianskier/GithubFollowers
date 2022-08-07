//
//  UIView+Extension.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-08-07.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
