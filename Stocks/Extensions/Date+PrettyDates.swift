//
//  Date+PrettyDates.swift
//  Stocks
//
//  Created by Milo Hill on 01/05/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

extension Date {
    func noOfDaysTo(date: Date) -> Int? {
        let calendar = Calendar(identifier: .gregorian)
        let start = calendar.startOfDay(for: self)
        let end = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        return components.day
    }
    
    func prettyPrintNoOfDaysTo(date: Date = Date()) -> String {
        guard let noOfDays = noOfDaysTo(date: date) else {
            return "Unknown"
        }
        
        if noOfDays == 0 {
            return "Today"
        } else if noOfDays == 1 {
            return "1 Day Ago"
        }
        
        return "\(noOfDays) Days Ago"
    }
}
