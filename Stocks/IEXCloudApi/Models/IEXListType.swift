//
//  IEXListType.swift
//  Stocks
//
//  https://iexcloud.io/docs/api/#list
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

enum IEXListType: String, Codable, Equatable, CaseIterable {
    case mostActive = "mostactive"
    case gainers = "gainers"
    case losers = "losers"
    case iexVolume = "iexvolume"
    case iexPercent = "iexpercent"

    func localize() -> String {
        switch self {
        case .mostActive:
            return "Most Active"
        case .gainers:
            return "Gainers"
        case .losers:
            return "Losers"
        case .iexVolume:
            return "Volume Traded"
        case .iexPercent:
            return "Percent Traded"
        }
    }
}
