//
//  IEXEndpoints.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift

struct IEXEndpoints {
    static func getNews(symbol: StockSymbol, count: Int) -> IEXEndpoint<[IEXNewsItem]> {
        return IEXEndpoint<[IEXNewsItem]>(
            path: "/stock/\(symbol)/news/last/\(count)",
            method: .get,
            queryItems: []
        )
    }
    
    static func getTop(symbols: [StockSymbol]) -> IEXEndpoint<[IEXQuote]> {
        return IEXEndpoint<[IEXQuote]>(
            path: "/tops",
            method: .get,
            queryItems: [
                URLQueryItem(name: "symbols", value: symbols.joined(separator: ","))
            ]
        )
    }
    
    static func getList(listType: IEXListType) -> IEXEndpoint<[IEXQuote]> {
        return IEXEndpoint<[IEXQuote]>(
            path: "/stock/market/list/\(listType.rawValue)",
            method: .get,
            queryItems: []
        )
    }
    
    static func getQuote(symbol: StockSymbol) -> IEXEndpoint<IEXQuote> {
        return IEXEndpoint<IEXQuote>(
            path: "/stock/\(symbol)/quote",
            method: .get,
            queryItems: []
        )
    }
    
    static func getCompany(symbol: StockSymbol) -> IEXEndpoint<IEXCompany> {
        return IEXEndpoint<IEXCompany>(
            path: "/stock/\(symbol)/company",
            method: .get,
            queryItems: []
        )
    }
}
