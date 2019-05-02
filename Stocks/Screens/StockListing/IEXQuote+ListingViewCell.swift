//
//  IEXQuote+ListingViewCell.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

extension IEXQuote {
    
    /// Convert the quote to a format usable
    /// by the StockListingViewCell
    ///
    /// - Returns: Formatted VM for StockListingViewCell
    func toListingCellViewModel() -> StockListingViewCell.ViewModel {
        return StockListingViewCell.ViewModel(
            title: companyName,
            subheading: symbol,
            value: getRoundedValue(value: latestPrice) ?? "Unknown",
            valueChange: PerecentageValueChange(percentChange: (changePercent ?? 0) * 100),
            imageUrl: symbol.logoUrl
        )
    }
    
    private func getRoundedValue(value: Double?) -> String? {
        guard let value = value else { return nil }
        return "$" + String(format: "%.2f", value)
    }
}
