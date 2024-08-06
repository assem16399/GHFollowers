//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Aasem Hany on 06/08/2024.
//

import Foundation

extension String{
    
    var convertToDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    
    var convertToDisplayFormate: String {
        guard let date = convertToDate else { return "N/A" }
        return date.convertToMonthYearFormat
    }
}
