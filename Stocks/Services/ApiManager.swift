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
        
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    single(.error(ApiError.noResponse))
                    return
                }
                
                debugPrint(httpResponse)
                
                guard error == nil else {
                    debugPrintOptional(error)
                    single(.error(error!))
                    return
                }

                guard 200..<300 ~= httpResponse.statusCode else {
                    single(.error(ApiError.invalidResponse(httpResponse)))
                    return
                }

                do {
                    let result = try decoder.decode(T.ResponseType.self, from: data)
                    single(.success(result))
                } catch {
                    debugPrint(error)
                    single(.error(ApiError.couldNotParseJSON))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

func debugPrintOptional(_ values: Any?...) {
    values.compactMap { $0 }.forEach { val in
        debugPrint(val)
    }
}
