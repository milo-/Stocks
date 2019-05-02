//
//  UIImage+Stocks.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit

class UIImageDownloader {
    static var shared = UIImageDownloader()
    
    var lookupTable: [Int: URLSessionDataTask] = [:]
    
    func prefetchImages(urls: [URL]) {
        urls.forEach { url in
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
            let task = URLSession.shared.dataTask(with: request)
            task.resume()
        }
    }
    
    func fetchImage(viewId: Int, url: URL, completion: @escaping (UIImage?) -> Void) {
        if let existingTask = lookupTable[viewId] {
            existingTask.cancel()
            lookupTable.removeValue(forKey: viewId)
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else { return }
            
            if self?.lookupTable[viewId] != nil {
                self?.lookupTable.removeValue(forKey: viewId)
            }
            
            let newImage = UIImage(data: data)
            completion(newImage)
        }
        
        lookupTable[viewId] = task
        
        task.resume()
    }
}

extension UIImageView {
    func asyncImage(url: URL?, placeholder: UIImage?) {
        self.image = placeholder
        guard let url = url else { return }
        
        UIImageDownloader.shared.fetchImage(viewId: hash, url: url, completion: { [weak self] image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.contentMode = .scaleAspectFit
                self?.image = image
                self?.layoutIfNeeded()
            }
        })
    }
}
