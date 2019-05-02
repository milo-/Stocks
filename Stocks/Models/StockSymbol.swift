//
//  Stock.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

typealias StockSymbol = String

extension StockSymbol {
    var logoUrl: URL? {
        // https://iexcloud.io/docs/api/#logo
        // Using google API directly to avoid using extra API credits
        return URL(string: "https://storage.googleapis.com/iex/api/logos/\(self).png")
    }
}
