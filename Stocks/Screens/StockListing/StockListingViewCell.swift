//
//  StockListingViewCell.swift
//  Stocks
//
//  Created by Milo Hill on 25/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit

class StockListingViewCell: UITableViewCell {
    let listingImageView = UIImageView(frame: .zero)
    
    let contentContainer = UIStackView.verticalStackView()
    let valueContainer = UIStackView.verticalStackView()
    
    let titleLabel = UILabel(frame: .zero)
    let valueLabel = UILabel(frame: .zero)
    let valueChangeLabel = UILabel(frame: .zero)
    let subheadLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        layout()
        
        StockListingViewCell.configure(imageView: listingImageView)
        StockListingViewCell.configure(titleLabel: titleLabel)
        StockListingViewCell.configure(valueLabel: valueLabel)
        StockListingViewCell.configure(subheadLabel: subheadLabel)
        StockListingViewCell.configure(valueChangedLabel: valueChangeLabel)
        
        contentView.layoutMargins = Constants.contentViewInsets
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewModel Configuration
    func configure(data: ViewModel) {
        titleLabel.text = data.title
        valueLabel.text = data.value
        setValueChanged(valueChange: data.valueChange)
        subheadLabel.text = data.subheading
        listingImageView.asyncImage(url: data.imageUrl, placeholder: #imageLiteral(resourceName: "MissingIcon"))
    }
    
    func setValueChanged(valueChange: PerecentageValueChange) {
        switch valueChange {
        case .decrease(_):
            valueChangeLabel.textColor = Colors.decrease
        case .increase(_):
            valueChangeLabel.textColor = Colors.increase
        default:
            valueChangeLabel.textColor = .black
        }
        valueChangeLabel.text = valueChange.formattedString()
    }
    
    // MARK: Layout
    func addSubviews() {
        contentView.addSubviewsUsingAutolayout(
            listingImageView,
            contentContainer,
            valueContainer
        )
        
        contentContainer.addArrangedSubviews(
            subheadLabel,
            titleLabel
        )
        
        valueContainer.addArrangedSubviews(
            valueChangeLabel,
            valueLabel
        )
    }
    
    func layout() {
        let layoutGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            listingImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            listingImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            listingImageView.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            listingImageView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            listingImageView.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor),
            
            contentContainer.leftAnchor.constraint(equalToSystemSpacingAfter: listingImageView.rightAnchor, multiplier: 1),
            contentContainer.topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor),
            contentContainer.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor),
            contentContainer.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
            
            valueContainer.leftAnchor.constraint(equalToSystemSpacingAfter: contentContainer.rightAnchor, multiplier: 1),
            valueContainer.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor),
            valueContainer.topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor),
            valueContainer.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor),
            valueContainer.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
        ])
        
        valueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        valueChangeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        valueChangeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        valueContainer.alignment = .trailing
        contentContainer.distribution = .fillProportionally
    }
    
    // MARK: Subview Configuration
    static func configure(imageView: UIImageView) {
        imageView.layer.cornerRadius = Constants.imageRadius
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.contentScaleFactor = 2
        imageView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }
    
    static func configure(titleLabel: UILabel) {
        titleLabel.font = .preferredFont(forTextStyle: .subheadline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    static func configure(subheadLabel: UILabel) {
        subheadLabel.font = .preferredFont(forTextStyle: .caption2)
        subheadLabel.adjustsFontForContentSizeCategory = true
        subheadLabel.numberOfLines = 2
        subheadLabel.lineBreakMode = .byWordWrapping
    }
    
    static func configure(valueLabel: UILabel) {
        valueLabel.font = .preferredFont(forTextStyle: .subheadline)
        valueLabel.adjustsFontForContentSizeCategory = true
    }
    
    static func configure(valueChangedLabel: UILabel) {
        valueChangedLabel.font = .preferredFont(forTextStyle: .caption2)
        valueChangedLabel.adjustsFontForContentSizeCategory = true
    }
    
    struct ViewModel {
        let title: String
        let subheading: String?
        let value: String
        let valueChange: PerecentageValueChange
        let imageUrl: URL?
    }
    
    // Mark: Constants
    struct Constants {
        static let imageRadius = CGFloat(3)
        static let edgeSpacing = CGFloat(5)
        static let imageHeight = CGFloat(50)
        static let imageWidth = CGFloat(50)
        static let contentViewInsets = UIEdgeInsets(
            top: edgeSpacing,
            left: edgeSpacing,
            bottom: edgeSpacing,
            right: edgeSpacing
        )
    }
    
    struct Colors {
        static let increase = UIColor(red: 87, green: 181, blue: 107)
        static let decrease = UIColor(red: 255, green: 97, blue: 117)
    }
}
