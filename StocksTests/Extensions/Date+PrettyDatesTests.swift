//
//  Date+PrettyDates.swift
//  StocksTests
//
//  Created by Milo Hill on 01/05/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import XCTest

@testable import Stocks

class Date_PrettyDates: XCTestCase {
    func testPrettyDate5Days() {
        let date = Date(timeIntervalSince1970: 1555771971) // 20th April 2019
        let today = Date(timeIntervalSince1970: 1556153571) // 25th April 2019
        
        let formatted = date.prettyPrintNoOfDaysTo(date: today)
        
        XCTAssertEqual(formatted, "5 Days Ago")
    }
    
    func testPrettyDate1Day() {
        let date = Date(timeIntervalSince1970: 1555771971) // 20th April 2019
        let today = Date(timeIntervalSince1970: 1555807971) // 21st April 2019
        
        let formatted = date.prettyPrintNoOfDaysTo(date: today)
        
        XCTAssertEqual(formatted, "1 Day Ago")
    }
    
    func testPrettyDateToday() {
        let date = Date(timeIntervalSince1970: 1555771971) // 20th April 2019
        let today = Date(timeIntervalSince1970: 1555772000) // 21st April 2019
        
        let formatted = date.prettyPrintNoOfDaysTo(date: today)
        
        XCTAssertEqual(formatted, "Today")
    }
}
