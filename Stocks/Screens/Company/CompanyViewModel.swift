//
//  CompanyViewModel.swift
//  Stocks
//
//  Created by Milo Hill on 29/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift

enum CompanyAction {
    case reload
    case openURL(URL)
}

struct CompanyState {
    let quote: IEXQuote
    let company: IEXCompany
    let news: [IEXNewsItem]
}

protocol CompanyViewModelProtocol {
    var title: String { get }
    func bind(input: Observable<CompanyAction>) -> Observable<ViewModelResult<CompanyState>>
}

class CompanyViewModel: CompanyViewModelProtocol {
    let title: String
    let symbol: StockSymbol
    let iexCloudApi: IEXCloudApiProtocol
    
    weak var delegate: AppCoordinatorDelegate?
    
    init(
        symbol: StockSymbol,
        iexCloudApi: IEXCloudApiProtocol = IEXCloudApi.instance
    ) {
        self.title = symbol
        self.symbol = symbol
        self.iexCloudApi = iexCloudApi
    }
    
    func bind(input: Observable<CompanyAction>) -> Observable<ViewModelResult<CompanyState>> {
        return input
            .do(onNext: { [weak self] action in
                guard case let .openURL(url) = action else { return }
                
                self?.delegate?.openUrl(url: url)
            })
            .flatMap { [weak self] action -> Observable<ViewModelResult<CompanyState>> in
                guard case .reload = action, let self = self else { return .empty() }
                
                return self.loadState(symbol: self.symbol)
            }
    }
    
    func loadState(symbol: StockSymbol) -> Observable<ViewModelResult<CompanyState>> {
        return Observable.zip(
                loadQuote(symbol: symbol),
                loadCompany(symbol: symbol),
                loadNews(symbol: symbol, count: 20)
            )
            .map { CompanyState(quote: $0.0, company: $0.1, news: $0.2) }
            .map { ViewModelResult.success($0) }
            .startWith(ViewModelResult.loading)
            .catchError { .of(ViewModelResult.error($0)) }
    }
    
    func loadQuote(symbol: StockSymbol) -> Observable<IEXQuote> {
        return iexCloudApi
            .getQuote(symbol: symbol)
            .asObservable()
    }
    
    func loadCompany(symbol: StockSymbol) -> Observable<IEXCompany> {
        return iexCloudApi
            .getCompany(symbol: symbol)
            .asObservable()
    }
    
    func loadNews(symbol: StockSymbol, count: Int) -> Observable<[IEXNewsItem]> {
        return iexCloudApi
            .getNews(symbol: symbol, count: count)
            .asObservable()
            .catchErrorJustReturn([]) // Don't bail if we can't load news, it's not essential
    }
}
