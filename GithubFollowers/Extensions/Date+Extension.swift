//
//  Date+Extension.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-30.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
