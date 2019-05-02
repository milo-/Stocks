//
//  IEXCloudApi.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift


protocol IEXCloudApiProtocol {
    func getNews(symbol: StockSymbol, count: Int) -> Single<[IEXNewsItem]>
    func getTop(symbols: [StockSymbol]) -> Single<[IEXQuote]>
    func getList(listType: IEXListType) -> Single<[IEXQuote]>
    func getQuote(symbol: StockSymbol) -> Single<IEXQuote>
    func getCompany(symbol: StockSymbol) -> Single<IEXCompany>
}

class IEXCloudApi: IEXCloudApiProtocol {
    static let instance = IEXCloudApi()
    
    func getNews(symbol: StockSymbol, count: Int) -> Single<[IEXNewsItem]> {
        return IEXEndpoints.getNews(symbol: symbol, count: count).createRequest()
    }

    func getTop(symbols: [StockSymbol]) -> Single<[IEXQuote]> {
        return IEXEndpoints.getTop(symbols: symbols).createRequest()
    }
    
    func getList(listType: IEXListType) -> Single<[IEXQuote]> {
        return IEXEndpoints.getList(listType: listType).createRequest()
    }
    
    func getQuote(symbol: StockSymbol) -> Single<IEXQuote> {
        return IEXEndpoints.getQuote(symbol: symbol).createRequest()
    }
    
    func getCompany(symbol: StockSymbol) -> Single<IEXCompany> {
        return IEXEndpoints.getCompany(symbol: symbol).createRequest()
    }
}
