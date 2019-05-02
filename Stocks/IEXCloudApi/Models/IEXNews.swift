//
//  IEXNewsItem.swift
//  Stocks
//
//  https://iexcloud.io/docs/api/#news
//
//  Created by Milo Hill on 29/04/2019.
//  Copyright © 2019 Milo Hill. All rights reserved.
//

import Foundation

struct IEXNewsItem: Codable, Equatable {
    let datetime: Date
    let headline: String
    let source: String?
    let url: URL?
    let summary: String
    let related: StockSymbol
    let image: String?
    let lang: String?
    let hasPaywall: Bool?

    init(
        datetime: Date,
        headline: String,
        source: String? = nil,
        url: URL? = nil,
        summary: String,
        related: StockSymbol,
        image: String? = nil,
        lang: String? = nil,
        hasPaywall: Bool? = nil
    ) {
        self.datetime = datetime
        self.headline = headline
        self.source = source
        self.url = url
        self.summary = summary
        self.related = related
        self.image = image
        self.lang = lang
        self.hasPaywall = hasPaywall
    }
}

extension IEXNewsItem {
    var imageUrl: URL? {
        guard let image = image else { return nil }
        return URL(string: image)
    }
}

enum Lang: String, Codable {
    case en = "en"
}
