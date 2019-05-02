//
//  StockListingViewController.swift
//  Stocks
//
//  Created by Milo Hill on 24/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StockListingViewController: UIViewController {
    let vm: StockListingViewModelProtocol
    let disposeBag = DisposeBag()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let listTypeButton = UIBarButtonItem(title: IEXListType.gainers.localize(), style: .plain, target: nil, action: nil)
    
    init(vm: StockListingViewModelProtocol) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubviews()
        layout()

        StockListingViewController.configure(controller: self)
        StockListingViewController.configure(tableView: tableView)

        bind(viewModel: vm)
        bind(itemSelected: tableView.rx.itemSelected)
    }

    static func configure(controller: UIViewController) {
        // Fix scroll snapping because navBar is translucent
        // https://stackoverflow.com/questions/48039046/ios-11-large-title-navigation-bar-snaps-instead-of-smooth-transition
        controller.extendedLayoutIncludesOpaqueBars = true
        controller.view.backgroundColor = .white
    }

    func addSubviews() {
        view.addSubviewsUsingAutolayout(tableView, activityIndicator)
        navigationItem.rightBarButtonItem = listTypeButton
    }
    
    func bind(viewModel: StockListingViewModelProtocol) {
        title = viewModel.title

        let pickedItem = didSelectListItem()
        let input = Observable.merge(
                didSelectModel(),
                pickedItem.map { StockListingAction.reload($0) }.asObservable()
            )
            .startWith(.reload(.gainers))
        
        let result = vm
            .bind(input: input)
            .asDriver(onErrorJustReturn: .success(StockListingState(listings: [])))

        bind(pickedlistItem: pickedItem)
        bind(success: result.flatMap { .from(optional: $0.success) })
        bind(loading: result.map { $0.loading })
    }

    func bind(pickedlistItem: Driver<IEXListType>) {
        pickedlistItem.map { $0.localize() }.drive(listTypeButton.rx.title).disposed(by: disposeBag)
    }

    func didSelectModel() -> Observable<StockListingAction> {
        return tableView
            .rx
            .modelSelected(IEXQuote.self)
            .map { StockListingAction.selectListing($0.symbol) }
    }

    func didSelectListItem() -> Driver<IEXListType> {
        return listTypeButton.rx.tap
            .flatMap { [unowned self] in
                self.createPicker()
            }
            .asDriver(onErrorJustReturn: .gainers)
    }
    
    func bind(success: Driver<StockListingState>) {
        success
            .map { $0.listings }
            .do(onNext: { listings in
                let imageUrls: [URL] = listings.compactMap { $0.symbol.logoUrl }
                UIImageDownloader.shared.prefetchImages(urls: imageUrls)
            })
            .drive(tableView.rx.items(cellIdentifier: "listingCell", cellType: StockListingViewCell.self)) { (_, quote, cell) in
                cell.configure(data: quote.toListingCellViewModel())
            }
            .disposed(by: disposeBag)
    }
    
    func bind(loading: Driver<Bool>) {
        loading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        bind(toScrollView: loading)
    }

    func bind(toScrollView loading: Driver<Bool>) {
        loading
            .filter { !$0 }
            .delay(.milliseconds(300))
            .asObservable()
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                UIView.animate(withDuration: Constants.animationDuration, animations: {
                    self?.tableView.alpha = 1
                })
            })
            .disposed(by: disposeBag)
    }
    
    func bind(itemSelected: ControlEvent<IndexPath>) {
        itemSelected
            .subscribe(onNext: { [weak self] index in
                self?.tableView.deselectRow(at: index, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    static func configure(tableView: UITableView) {
        tableView.register(StockListingViewCell.self, forCellReuseIdentifier: "listingCell")
        tableView.alpha = 0
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)            
        ])
    }

    func createPicker() -> Maybe<IEXListType> {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        return Maybe.create(subscribe: { [weak self] observer in
            IEXListType.allCases.forEach { listType in
                actionSheet.addAction(
                    UIAlertAction(title: listType.localize(), style: .default, handler: { _ in
                        observer(.success(listType))
                    })
                )
            }

            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in observer(.completed) }))

            actionSheet.view.tintColor = .stocksTheme

            self?.present(actionSheet, animated: true)

            return Disposables.create()
        })
    }

    struct Constants {
        static let animationDuration = Double(0.5)
    }
}
