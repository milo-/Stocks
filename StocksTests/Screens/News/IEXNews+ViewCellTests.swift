//
//  IEXNewsItem+ViewCellTests.swift
//  StocksTests
//
//  Created by Milo Hill on 30/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import XCTest

@testable import Stocks

class IEXNewsItem_ViewCellTests: XCTestCase {
    
    func testToCellViewModel() {
        let news = IEXNewsItem(
            datetime: Date(timeIntervalSince1970: 1556190000),
            headline: "Freetrade crashes CrowdCube",
            source: "Techcrunch",
            url: nil,
            summary: "Freetrade had to pause our crowdfunding after a few minutes today due to the high number of people trying to invest",
            related: "FREE",
            image: nil,
            lang: nil,
            hasPaywall: nil
        )
        
        let vm = news.toCellViewModel()
        
        XCTAssertEqual(vm.title, "Freetrade crashes CrowdCube")
        XCTAssertEqual(vm.description, "Techcrunch")
        XCTAssertTrue(vm.date.contains("Days Ago"))
    }
    
    func testToCellViewModelUnknownSource() {
        let news = IEXNewsItem(
            datetime: Date(timeIntervalSince1970: 1556190000),
            headline: "Freetrade crashes CrowdCube",
            source: nil,
            summary: "Freetrade had to pause our crowdfunding after a few minutes today due to the high number of people trying to invest",
            related: "FREE"
        )
        
        let vm = news.toCellViewModel()
        
        XCTAssertEqual(vm.title, "Freetrade crashes CrowdCube")
        XCTAssertEqual(vm.description, "Unknown")
        XCTAssertTrue(vm.date.contains("Days Ago"))
    }
}
