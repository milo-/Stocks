//
//  IEXEndpoint.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

struct IEXEndpoint<ResponseType: Codable>: Endpoint {
    let token = "" // 🤐 Nothing to see here...
    let host = "cloud.iexapis.com"
    let basePath: String? = "/stable"
    
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = host
        components.queryItems = queryItems + [URLQueryItem(name: "token", value: token)]
        components.path = (basePath ?? "") + path
        
        return components.url
    }
}
