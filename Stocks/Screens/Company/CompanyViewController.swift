//
//  CompanyViewController.swift
//  Stocks
//
//  A container viewController wrapping anumber
//  of child View Controllers
//
//  Created by Milo Hill on 30/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CompanyViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView.verticalStackView()
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    let vm: CompanyViewModelProtocol
    
    let newsVC = StockNewsViewController(nibName: nil, bundle: nil)
    let infoVC = CompanyInfoViewController(nibName: nil, bundle: nil)
    
    let disposeBag = DisposeBag()
    
    init(vm: CompanyViewModelProtocol) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubviews()
        layout()

        CompanyViewController.configure(scrollView: scrollView)
        CompanyViewController.configure(controller: self)

        bind(viewModel: vm)
    }
    
    // Mark: Data Bindings
    func bind(viewModel: CompanyViewModelProtocol) {
        title = viewModel.title
        
        let reload = Observable.of(CompanyAction.reload)
        let newsSelected = handleNewsSelected(action: newsVC.publishSubject)
        let input = Observable.merge(reload, newsSelected)
       
        let result = viewModel
            .bind(input: input)
            .asDriver(onErrorJustReturn: .error(ApiError.noResponse)) // TODO: Use real error

        bind(success: result.flatMap { .from(optional: $0.success) })
        bind(loading: result.map { $0.loading })
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
            .drive(onNext: { [weak self] _ in
                UIView.animate(withDuration: Constants.animationDuration, animations: {
                    self?.scrollView.alpha = 1
                })
            })
            .disposed(by: disposeBag)
    }
    
    func bind(success: Driver<CompanyState>) {
        let company = success.map { $0.company }.asObservable()
        let quote = success.map { $0.quote }.asObservable()
        let news = success.map { $0.news }.asObservable()
        
        newsVC.bind(title: "News", news: news)
        infoVC.bind(company: company, quote: quote)
    }
    
    func handleNewsSelected(action: Observable<StockNewsAction>) -> Observable<CompanyAction> {
        return action.compactMap { action -> CompanyAction? in
            if case let .selected(news) = action, let url = news.url  {
                return CompanyAction.openURL(url)
            }
            
            return nil
        }
    }

    // MARK: Layout
    func addSubviews() {
        addChild(newsVC)
        addChild(infoVC)

        view.addSubviewsUsingAutolayout(
            scrollView,
            activityIndicator
        )
        
        scrollView.addSubviewsUsingAutolayout(stackView)
        
        stackView.addArrangedSubviews(
            infoVC.view,
            newsVC.view
        )
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        stackView.distribution = .fill
        stackView.setCustomSpacing(Constants.sectionSpacing, after: infoVC.view)

        newsVC.view.setContentCompressionResistancePriority(.required, for: .horizontal)
        newsVC.view.setContentHuggingPriority(.required, for: .horizontal)
    }

    // MARK: Subview Configuration
    static func configure(scrollView: UIScrollView) {
        scrollView.alpha = 0 // Hide on initial load
        scrollView.alwaysBounceVertical = true
    }

    static func configure(controller: UIViewController) {
        // Fix scroll snapping because navBar is translucent
        // https://stackoverflow.com/questions/48039046
        controller.extendedLayoutIncludesOpaqueBars = true
        controller.view.backgroundColor = .white
    }

    /// MARK: Constants
    struct Constants {
        static let animationDuration = Double(0.5)
        static let sectionSpacing = CGFloat(50)
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

class UILabelInset: UILabel {
    var insets: UIEdgeInsets
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + insets.left + insets.right,
            height: size.height + insets.top + insets.bottom
        )
    }
}
