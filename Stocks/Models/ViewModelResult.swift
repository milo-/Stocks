//
//  ViewModelResult.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

enum ViewModelResult<T> {
    case loading
    case success(T)
    case error(Error)
}

extension ViewModelResult {
    var loading: Bool {
        if case .loading = self {
            return true
        }
        
        return false
    }
    
    var success: T? {
        if case .success(let result) = self {
            return result
        }
        
        return nil
    }
    
    var error: Error? {
        if case .error(let error) = self {
            return error
        }
        
        return nil
    }
}
