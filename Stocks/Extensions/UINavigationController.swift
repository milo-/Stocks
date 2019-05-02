//
//  UINavigationController.swift
//  Stocks
//
//  Created by Milo Hill on 01/05/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    // Create a white view to go behind the status bar
    // otherwise
    private func makeWhiteView() -> UIView {
        let whiteView = UIView(frame: CGRect(
            x: 0,
            y:0,
            width: UIApplication.shared.statusBarFrame.width,
            height: UIApplication.shared.statusBarFrame.height)
        )
        
        whiteView.backgroundColor = .white
        
        return whiteView
    }
    
    /// Theme the navigationBar with a white background and
    /// no shadow/line below the largeTitles
    func makeStocksTheme() {
        navigationBar.prefersLargeTitles = true
        navigationBar.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .default
        
        // Remove the shadow below the largeTitle
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .stocksTheme
        
        view.insertSubview(makeWhiteView(), belowSubview: navigationBar)
    }
}
