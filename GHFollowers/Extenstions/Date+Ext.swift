//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Aasem Hany on 06/08/2024.
//

import Foundation

extension Date{
    var convertToMonthYearFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }
}
