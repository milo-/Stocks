//
//  UIStackView.swift
//  Stocks
//
//  Created by Milo Hill on 29/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    static func verticalStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        
        stackView.axis = .vertical
        
        return stackView
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
