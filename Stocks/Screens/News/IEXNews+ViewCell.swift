//
//  IEXNewsItem+ViewCell.swift
//  Stocks
//
//  Created by Milo Hill on 29/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

extension IEXNewsItem {
    /// Convert the quote to a format usable
    /// by the StockNewsViewCell
    ///
    /// - Returns: Formatted VM for StockListingViewCell
    func toCellViewModel() -> StockNewsViewCell.ViewModel {
        return StockNewsViewCell.ViewModel(
            date: datetime.prettyPrintNoOfDaysTo(),
            title: headline,
            description: source ?? "Unknown"
        )
    }
}
