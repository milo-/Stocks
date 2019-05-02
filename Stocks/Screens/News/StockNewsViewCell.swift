//
//  StockNewsViewCell.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit

class StockNewsViewCell: UITableViewCell {
    let titleLabel = UILabel(frame: .zero)
    let metaLabel = UILabel(frame: .zero)
    let contentContainer = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        layout()
        
        StockNewsViewCell.configure(metaLabel: metaLabel)
        StockNewsViewCell.configure(titleLabel: titleLabel)
        StockNewsViewCell.configure(contentContainer: contentContainer)
        
        contentView.layoutMargins = Constants.contentViewInsets
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func addSubviews() {
        contentView.addSubviewsUsingAutolayout(
            contentContainer
        )
        
        contentContainer.addArrangedSubviews(
            metaLabel,
            titleLabel
        )
    }
    
    func layout() {
        let layoutGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            contentContainer.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            contentContainer.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            contentContainer.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor)
        ])

        contentContainer.setCustomSpacing(3, after: metaLabel)
    }
    
    func configure(vm: ViewModel) {
        metaLabel.text = vm.date + " / " + vm.description
        titleLabel.text = vm.title
    }
    
    static func configure(titleLabel: UILabel) {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    static func configure(metaLabel: UILabel) {
        metaLabel.numberOfLines = 1
        metaLabel.adjustsFontForContentSizeCategory = true
        metaLabel.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
        metaLabel.textColor = Colors.meta
    }
    
    static func configure(contentContainer: UIStackView) {
        contentContainer.axis = .vertical
    }
    
    struct ViewModel{
        let date: String
        let title: String
        let description: String
    }
    
    struct Constants {
        static let imageRadius = CGFloat(3)
        static let edgeSpacing = CGFloat(5)
        static let imageHeight = CGFloat(50)
        static let imageWidth = CGFloat(50)
        static let contentViewInsets = UIEdgeInsets(
            top: 10,
            left: edgeSpacing,
            bottom: 10,
            right: edgeSpacing
        )
    }
    
    struct Colors {
        static let meta = UIColor.black.withAlphaComponent(0.8)
    }
}
