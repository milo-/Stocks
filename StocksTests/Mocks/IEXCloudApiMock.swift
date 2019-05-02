//
//  IEXCloudApiMock.swift
//  StocksTests
//
//  Created by Milo Hill on 30/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift
import RxTest

@testable import Stocks

class IEXCloudApiMock: IEXCloudApiProtocol {
    var scheduler: TestScheduler
    
    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }
    
    var newsMock: [IEXNewsItem] {
        return [
            IEXNewsItem(
                datetime: Date(timeIntervalSince1970: 1556190000),
                headline: "Freetrade",
                summary: "Freetrade had to pause our crowdfunding after a few minutes today due to the high number of people trying to invest",
                related: "FREE"
            )
        ]
    }
    
    var quoteMock: [IEXQuote] {
        return [
            IEXQuote(
                symbol: "FREE",
                companyName: "Freetrade",
                iexBidSize: 1
            )
        ]
    }
    
    var companyMock: IEXCompany {
        return IEXCompany(symbol: "AAPL", companyName: "Apple")
    }
    
    func getNews(symbol: StockSymbol, count: Int) -> Single<[IEXNewsItem]> {
        return scheduler.createColdObservable([
            .next(50, newsMock),
            .completed(50)
        ]).asSingle()
    }
    
    func getTop(symbols: [StockSymbol]) -> Single<[IEXQuote]> {
        return scheduler.createColdObservable([
            .next(50, quoteMock),
            .completed(50)
        ]).asSingle()
    }
    
    func getList(listType: IEXListType) -> Single<[IEXQuote]> {
        return scheduler.createColdObservable([
            .next(50, quoteMock),
            .completed(50)
        ]).asSingle()
    }
    
    func getQuote(symbol: StockSymbol) -> Single<IEXQuote> {
        return scheduler.createColdObservable([
            .next(50, quoteMock[0]),
            .completed(50)
        ]).asSingle()
    }
    
    func getCompany(symbol: StockSymbol) -> Single<IEXCompany> {
        return scheduler.createColdObservable([
            .next(50, companyMock),
            .completed(50)
        ]).asSingle()
    }
}

class IEXCloudApiThrowing: IEXCloudApiMock {
    override func getNews(symbol: StockSymbol, count: Int) -> Single<[IEXNewsItem]> {
        return scheduler.createColdObservable([
            .error(60, ApiError.noResponse)
        ]).asSingle()
    }
    
    override func getTop(symbols: [StockSymbol]) -> Single<[IEXQuote]> {
        return scheduler.createColdObservable([
            .error(60, ApiError.noResponse)
        ]).asSingle()
    }
    
    override func getList(listType: IEXListType) -> Single<[IEXQuote]> {
        return scheduler.createColdObservable([
            .error(60, ApiError.noResponse)
        ]).asSingle()
    }

    override func getQuote(symbol: StockSymbol) -> Single<IEXQuote> {
        return scheduler.createColdObservable([
            .error(60, ApiError.noResponse)
        ]).asSingle()
    }

    override func getCompany(symbol: StockSymbol) -> Single<IEXCompany> {
        return scheduler.createColdObservable([
            .error(60, ApiError.noResponse)
        ]).asSingle()
    }
}
