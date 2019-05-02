//
//  ViewModelResult+RxSwift.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift

extension ViewModelResult {
    var loadingObs: Observable<Bool> {
        return Observable.of(loading)
    }
    
    var successObs: Observable<T> {
        return Observable.from(optional: success)
    }
    
    var errorObs: Observable<Error> {
        return Observable.from(optional: error)
    }
}
