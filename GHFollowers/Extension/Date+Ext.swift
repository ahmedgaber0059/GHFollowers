//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Ahmed Gaber on 11/3/20.
//  Copyright © 2020 com.ahmedgaber. All rights reserved.
//

import Foundation

extension Date {
    
    func ConvertToMonthYearFormat ()->String{
        
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
