//
//  IEXEndpoint+ApiManager.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift

extension IEXEndpoint {
    // Helper to create a request for the given endpoint
    func createRequest() -> Single<ResponseType> {
        return ApiManager.shared.createRequest(endpoint: self, decoder: .IEXDecoder)
    }
}
