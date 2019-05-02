//
//  StockListingViewModelTests.swift
//  StocksTests
//
//  Created by Milo Hill on 30/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import Stocks

class StockListingViewModelTests: XCTestCase {
    var scheduler: TestScheduler!
    var mockApi: IEXCloudApiProtocol!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        mockApi = IEXCloudApiMock(scheduler: scheduler)
    }

    func testLoadingListings() {
        let model = StockListingViewModel(iexCloudApi: mockApi)
        let reloadObs = scheduler.createColdObservable([
            .next(0, StockListingAction.reload(.gainers)),
            .next(80, StockListingAction.reload(.mostActive)),
        ])
        let observer = scheduler.createObserver(ViewModelResult<StockListingState>.self)

        model
            .bind(input: reloadObs.asObservable())
            .subscribe(observer)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(observer.events.count, 4)

        XCTAssertEqual(observer.events[0].value.element?.loading, true)

        XCTAssertEqual(observer.events[1].value.element?.success?.listings.count, 1)
        XCTAssertEqual(observer.events[1].time, 50)

        XCTAssertEqual(observer.events[0].value.element?.loading, true)

        XCTAssertEqual(observer.events[3].value.element?.success?.listings.count, 1)
        XCTAssertEqual(observer.events[3].time, 130)
    }
}
