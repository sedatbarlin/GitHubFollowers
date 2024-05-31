//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Sedat on 31.05.2024.
//

import Foundation

extension Date{
    func convertToMonthYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
