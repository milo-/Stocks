//
//  StockListingViewModel.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift

enum StockListingAction {
    case reload(IEXListType)
    case selectListing(StockSymbol)
}

struct StockListingState {
    let listings: [IEXQuote]
}

protocol StockListingViewModelProtocol {
    var title: String { get }
    func bind(input: Observable<StockListingAction>) -> Observable<ViewModelResult<StockListingState>>
}

class StockListingViewModel: StockListingViewModelProtocol {
    let title = "Stocks"
    
    let iexCloudApi: IEXCloudApiProtocol
    
    weak var delegate: AppCoordinatorDelegate?
    
    init(iexCloudApi: IEXCloudApiProtocol = IEXCloudApi.instance) {
        self.iexCloudApi = iexCloudApi
    }
    
    func bind(input: Observable<StockListingAction>) -> Observable<ViewModelResult<StockListingState>> {
        return input.flatMap { [weak self] action -> Observable<ViewModelResult<StockListingState>> in
            guard let self = self else { return .empty() }
            
            switch action {
            case .reload(let listType):
                return self.loadListing(listType: listType)
            case .selectListing(let symbol):
                self.delegate?.selectListing(symbol: symbol)
                return .empty()
            }
        }
    }
    
    func loadListing(listType: IEXListType) -> Observable<ViewModelResult<StockListingState>> {
        return iexCloudApi
            .getList(listType: listType)
            .asObservable()
            .map { StockListingState(listings: $0) }
            .map { ViewModelResult.success($0) }
            .startWith(ViewModelResult.loading)
            .catchError { .of(ViewModelResult.error($0)) }
    }
}
