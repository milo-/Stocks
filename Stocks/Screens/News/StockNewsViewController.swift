//
//  StockNews.swift
//  Stocks
//
//  Created by Milo Hill on 29/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum StockNewsAction {
    case selected(IEXNewsItem)
}

class StockNewsViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let headerLabel = UILabel(frame: .zero)
    
    var tableHeightConstraint: NSLayoutConstraint!
    
    let publishSubject = PublishSubject<StockNewsAction>()
    
    override func viewDidLoad() {
        view.addSubviewsUsingAutolayout(headerLabel, tableView)
        
        layout()

        bind(itemSelected: tableView.rx.modelSelected(IEXNewsItem.self))
        bind(cellDisplayed: tableView.rx.didEndDisplayingCell)

        StockNewsViewController.configure(tableView: tableView)
        StockNewsViewController.configure(headerLabel: headerLabel)

        publishSubject.disposed(by: disposeBag)
    }
    
    func bind(title: String, news: Observable<[IEXNewsItem]>) {
        headerLabel.text = title

        let result = news.asDriver(onErrorJustReturn: [])

        bind(toTable: result)
        bind(toHideView: result)
    }
    
    func bind(toTable success: Driver<[IEXNewsItem]>) {
        success
            .do(onNext: { news in
                let imageUrls: [URL] = news.compactMap { $0.imageUrl }
                UIImageDownloader.shared.prefetchImages(urls: imageUrls)
            })
            .drive(tableView.rx.items(cellIdentifier: "listingCell", cellType: StockNewsViewCell.self)) { (row, quote, cell) in
                cell.configure(vm: quote.toCellViewModel())
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }

    func bind(toHideView success: Driver<[IEXNewsItem]>) {
        success.map { $0.count == 0 }.drive(view.rx.isHidden).disposed(by: disposeBag)
    }

    func bind(itemSelected: ControlEvent<IEXNewsItem>) {
        itemSelected
            .map { StockNewsAction.selected($0) }
            .bind(to: publishSubject)
            .disposed(by: disposeBag)
    }

    /// Update the tableHeight constraint
    /// so the parentViewControllers stack view
    /// will fit it correctly
    ///
    /// - Parameter cellDisplayed: RxTableView didEndDisplayingCellEvent
    func bind(cellDisplayed: ControlEvent<DidEndDisplayingCellEvent>) {
        cellDisplayed
            .subscribe(onNext: { [weak self] _ in
                self?.updateTableHeight()
            })
            .disposed(by: disposeBag)
    }
    
    func updateTableHeight() {
        guard tableHeightConstraint.constant != tableView.contentSize.height else { return }
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
    static func configure(tableView: UITableView) {
        tableView.isScrollEnabled = false
        tableView.scrollsToTop = false
        tableView.register(StockNewsViewCell.self, forCellReuseIdentifier: "listingCell")
    }

    static func configure(headerLabel: UILabel) {
        headerLabel.text = "Latest News"
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        headerLabel.adjustsFontForContentSizeCategory = true
    }
    
    func layout() {
        tableHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor),
            headerLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableHeightConstraint
        ])
    }
}
