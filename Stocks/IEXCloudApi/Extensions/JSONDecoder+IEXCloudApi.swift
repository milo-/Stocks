//
//  JSONDecoder+Stocks.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

extension JSONDecoder {
    /// Returns a JSONDecoder supporting
    /// IEX milliseconds date format
    ///
    /// - Returns: JSONDecoder
    static var IEXDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }
}
