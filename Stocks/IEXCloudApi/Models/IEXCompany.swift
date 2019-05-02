//
//  IEXCompany.swift
//  Stocks
//
//  https://iexcloud.io/docs/api/#company
//
//  Created by Milo Hill on 30/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

struct IEXCompany: Codable {
    let symbol: String
    let companyName: String
    let employees: Int?
    let exchange: String?
    let industry: String?
    let website: String?
    let description: String?
    let ceo: String?
    let issueType: String?
    let sector: String?
    let tags: [String]?
    
    init(
        symbol: String,
        companyName: String,
        employees: Int? = nil,
        exchange: String? = nil,
        industry: String? = nil,
        website: String? = nil,
        description: String? = nil,
        ceo: String? = nil,
        issueType: String? = nil,
        sector: String? = nil,
        tags: [String]? = nil
    ) {
        self.symbol = symbol
        self.companyName = companyName
        self.employees = employees
        self.exchange = exchange
        self.industry = industry
        self.website = website
        self.description = description
        self.ceo = ceo
        self.issueType = issueType
        self.sector = sector
        self.tags = tags
    }
}
