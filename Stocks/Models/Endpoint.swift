//
//  Endpoint.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

enum HTTPMethod: String, Codable {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol Endpoint {
    associatedtype ResponseType: Codable
    
    var path: String { get }
    var url: URL? { get }
    var host: String { get }
    var basePath: String? { get }
    var queryItems: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.queryItems = queryItems
        components.path = (basePath ?? "") + path
        components.host = host
        
        return components.url
    }
}
