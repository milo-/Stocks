//
//  Api.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import RxSwift

enum ApiError: Error {
    case noResponse
    case couldNotParseJSON
    case invalidURL
    case invalidResponse(HTTPURLResponse)
}

struct ApiManager {
    static let shared = ApiManager()
    
    func createRequest<T: Endpoint>(endpoint: T, decoder: JSONDecoder = JSONDecoder()) -> Single<T.ResponseType> {
        guard let url = endpoint.url else { return Single.error(ApiError.invalidURL) }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20)
        request.httpMethod = endpoint.method.rawValue

        return URLSession
            .shared
            .rx
            .data(request: request)
            .map { data in
                do {
                    return try decoder.decode(T.ResponseType.self, from: data)
                } catch {
                    debugPrint(error)
                    throw ApiError.couldNotParseJSON
                }
            }
            .catchError { error in
                debugPrint(error)
                return .error(error)
            }
            .asSingle()
    }
}

func debugPrintOptional(_ values: Any?...) {
    values.compactMap { $0 }.forEach { val in
        debugPrint(val)
    }
}
