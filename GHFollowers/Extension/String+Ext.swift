//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/3/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation

extension String {

    func ConvertToDate()->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ar_EG")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    
    func ConvertToDisplayFormat() ->String{
        guard let date = self.ConvertToDate() else { return "N/A"}
        return date.ConvertToMonthYearFormat()
    }
}
