//
//  Quote.swift
//  Stocks
//
//  https://iexcloud.io/docs/api/#quote
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

struct IEXQuote: Codable, Equatable {
    let symbol: StockSymbol
    let companyName: String
    
    let iexNewOpen: Double?
    let openTime: Date?
    let close: Double?
    let closeTime: Date?
    let high: Double?
    let low: Double?
    let latestPrice: Double?
    let latestSource: String?
    let latestTime: String?
    let latestUpdate: Date?
    let latestVolume: Int?
    let iexRealtimePrice: Double?
    let iexRealtimeSize: Int?
    let iexLastUpdated: Date?
    let delayedPrice: Double?
    let delayedPriceTime: Int?
    let extendedPrice: Double?
    let extendedChange: Double?
    let extendedChangePercent: Double?
    let extendedPriceTime: Date?
    let previousClose: Double?
    let change: Double?
    let changePercent: Double?
    let iexMarketPercent: Double?
    let iexVolume: Int?
    let avgTotalVolume: Int?
    let iexBidPrice: Double?
    let iexBidSize: Double?
    let iexAskPrice: Double?
    let iexAskSize: Double?
    let marketCap: Int?
    let peRatio: Double?
    let week52High: Double?
    let week52Low: Double?
    let ytdChange: Double?
    
    init(
        symbol: StockSymbol,
        companyName: String,
        
        iexNewOpen: Double? = nil,
        openTime: Date? = nil,
        close: Double? = nil,
        closeTime: Date? = nil,
        high: Double? = nil,
        low: Double? = nil,
        latestPrice: Double? = nil,
        latestSource: String? = nil,
        latestTime: String? = nil,
        latestUpdate: Date? = nil,
        latestVolume: Int? = nil,
        iexRealtimePrice: Double? = nil,
        iexRealtimeSize: Int? = nil,
        iexLastUpdated: Date? = nil,
        delayedPrice: Double? = nil,
        delayedPriceTime: Int? = nil,
        extendedPrice: Double? = nil,
        extendedChange: Double? = nil,
        extendedChangePercent: Double? = nil,
        extendedPriceTime: Date? = nil,
        previousClose: Double? = nil,
        change: Double? = nil,
        changePercent: Double? = nil,
        iexMarketPercent: Double? = nil,
        iexVolume: Int? = nil,
        avgTotalVolume: Int? = nil,
        iexBidPrice: Double? = nil,
        iexBidSize: Double? = nil,
        iexAskPrice: Double? = nil,
        iexAskSize: Double? = nil,
        marketCap: Int? = nil,
        peRatio: Double? = nil,
        week52High: Double? = nil,
        week52Low: Double? = nil,
        ytdChange: Double? = nil
    ) {
        self.symbol = symbol
        self.companyName = companyName
        
        self.iexNewOpen = iexNewOpen
        self.openTime = openTime
        self.close = close
        self.closeTime = closeTime
        self.high = high
        self.low = low
        self.latestPrice = latestPrice
        self.latestSource = latestSource
        self.latestTime = latestTime
        self.latestUpdate = latestUpdate
        self.latestVolume = latestVolume
        self.iexRealtimePrice = iexRealtimePrice
        self.iexRealtimeSize = iexRealtimeSize
        self.iexLastUpdated = iexLastUpdated
        self.delayedPrice = delayedPrice
        self.delayedPriceTime = delayedPriceTime
        self.extendedPrice = extendedPrice
        self.extendedChange = extendedChange
        self.extendedChangePercent = extendedChangePercent
        self.extendedPriceTime = extendedPriceTime
        self.previousClose = previousClose
        self.change = change
        self.changePercent = changePercent
        self.iexMarketPercent = iexMarketPercent
        self.iexVolume = iexVolume
        self.avgTotalVolume = avgTotalVolume
        self.iexBidPrice = iexBidPrice
        self.iexBidSize = iexBidSize
        self.iexAskPrice = iexAskPrice
        self.iexAskSize = iexAskSize
        self.marketCap = marketCap
        self.peRatio = peRatio
        self.week52High = week52High
        self.week52Low = week52Low
        self.ytdChange = ytdChange
    }
}
