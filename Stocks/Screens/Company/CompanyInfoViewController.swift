//
//  CompanyViewController.swift
//  Stocks
//
//  Created by Milo Hill on 30/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CompanyInfoViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let stackView = UIStackView.verticalStackView()

    let symbolLabel = UILabel(frame: .zero)
    let nameLabel = UILabel(frame: .zero)
    let summaryLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        addSubviews()
        layout()

        CompanyInfoViewController.configure(summaryLabel: summaryLabel)
        CompanyInfoViewController.configure(nameLabel: nameLabel)
    }
    
    // MARK: Layout
    func addSubviews() {
        view.addSubviewsUsingAutolayout(
            stackView
        )
        
        stackView.addArrangedSubviews(
            nameLabel,
            summaryLabel
        )
    }

    static func configure(summaryLabel: UILabel) {
        summaryLabel.numberOfLines = 5
        summaryLabel.lineBreakMode = .byWordWrapping
        summaryLabel.font = .preferredFont(forTextStyle: .subheadline)
    }

    static func configure(nameLabel: UILabel) {
        nameLabel.numberOfLines = 2
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.lineBreakMode = .byWordWrapping
    }
    
    func layout() {
        let layoutGuide = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            stackView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor)
        ])
    }
    
    func bind(company: Observable<IEXCompany>, quote: Observable<IEXQuote>) {
        let bindings = [
            company.map { $0.companyName }.bind(to: nameLabel.rx.text),
            company.map { $0.symbol }.bind(to: symbolLabel.rx.text),
            company.map { $0.description }.bind(to: summaryLabel.rx.text)
        ]
        
        disposeBag.insert(bindings)
    }
}
