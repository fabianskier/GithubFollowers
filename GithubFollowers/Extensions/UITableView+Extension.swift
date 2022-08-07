//
//  UITableView+Extension.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-08-07.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
