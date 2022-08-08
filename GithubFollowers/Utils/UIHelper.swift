//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-25.
//

import UIKit

// we use enum instead of struct,
// because struct allow us initialize an empty UIHelper
// and we don't want to do that
//
// let helper = UIHelper() => empty initialization
enum UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height:  itemWidth + 40)
        
        return flowLayout
    }
}
