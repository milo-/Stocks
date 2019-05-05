//
//  AppCoordinator.swift
//  Stocks
//
//  Created by Milo Hill on 29/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorDelegate: class {
    func selectListing(symbol: StockSymbol)
    func openUrl(url: URL)
}

class AppCoordinator: AppCoordinatorDelegate {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        openListings()
    }
    
    func openListings() {
        let vm = StockListingViewModel()
        let vc = StockListingViewController(vm: vm)
        
        vm.delegate = self
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func selectListing(symbol: StockSymbol) {
        let vm = CompanyViewModel(symbol: symbol)
        let vc = CompanyViewController(vm: vm)
        
        vm.delegate = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openUrl(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
