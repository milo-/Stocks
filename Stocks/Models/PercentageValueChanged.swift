//
//  ValueChanged.swift
//  Stocks
//
//  Created by Milo Hill on 30/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

enum PerecentageValueChange {
    case increase(Double)
    case decrease(Double)
    case none
    
    init(percentChange: Double) {
        if percentChange > 0 {
            self = .increase(percentChange)
        } else if percentChange < 0 {
            self = .decrease(percentChange)
        } else {
            self = .none
        }
    }
    
    func formattedString() -> String {
        switch self {
        case .decrease(let value), .increase(let value):
            return String(format: "%.2f", value) + "%"
        case .none:
            return "0%"
        }
        
    }
}
