//
//  NewsResponseModel.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

struct NewsResponseModel: Codable, Equatable {
    let results: [NewsModel]
}

struct NewsModel: Codable, Equatable {
    let uri: String?
    let url: String?
    let id: Int?
    let assetId: Int?
    let source: String?
    let publishedDate: String?
    let updated: String?
    let section: String?
    let subsection: String?
    let nytdsection: String?
    let adxKeywords: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    let media: MediaModel?
    
    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetId = "assets_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case nytdsection
        case adxKeywords = "adx_keywords"
        case byline
        case type
        case title
        case abstract
        case media
    }
}

struct MediaModel: Codable, Equatable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let mediaMetadata: [MediaMetadataModel]?
    
    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadataModel: Codable, Equatable {
    let url: String?
    let format: String?
    let height: Int
    let width: Int
}
