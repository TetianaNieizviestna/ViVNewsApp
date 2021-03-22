//
//  NewsResponseModel.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation
import CoreData

struct NewsResponseModel: Codable, Equatable{
    let results: [NewsModel]
}

struct NewsModel: Codable, Equatable, ManagedObjectConvertible {
    func toManagedObject(object: NSManagedObject) -> NSManagedObject? {
        if let id = self.id {
            if let object = object as? NewsModelData {
                object.url = self.url
                object.id = Int64(id)
                object.source = self.source
                object.publishedDate = self.publishedDate
                object.section = self.section
                object.subsection = self.subsection
                object.nytdsection = self.nytdsection
                object.adxKeywords = self.adxKeywords
                object.byline = self.byline
                object.type = self.type
                object.title = self.title
                object.abstract = self.abstract
                if let media = self.media {
                    let mediaSet = media.map { element -> MediaModelData in
                        (CoreDataServices.getObject(element, MediaModelData.self) ?? MediaModelData())
                    }
                    object.media = NSSet.init(array: mediaSet)
                }
            }
        }
        return object
    }
    
    let url: String?
    let id: Int?
    let source: String?
    let publishedDate: String?
    let section: String?
    let subsection: String?
    let nytdsection: String?
    let adxKeywords: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    let media: [MediaModel]?
    
    enum CodingKeys: String, CodingKey {
        case url, id
        case source
        case publishedDate = "published_date"
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

struct MediaModel: Codable, Equatable, ManagedObjectConvertible {
    func toManagedObject(object: NSManagedObject) -> NSManagedObject? {
        if let object = object as? MediaModelData {
            object.type = self.type
            object.subtype = self.subtype
            object.caption = self.caption
            if let mediaMetadata = self.mediaMetadata {
                let mediaMetadataList = mediaMetadata.compactMap { element -> MediaMetadataModelData? in
                    guard let element = element else { return nil }
                    return (CoreDataServices.getObject(element, MediaMetadataModelData.self) ?? MediaMetadataModelData())
                }
                object.mediaMetadata = NSSet.init(array: mediaMetadataList)
            }
        }
        return object
    }
    
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let mediaMetadata: [MediaMetadataModel?]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadataModel: Codable, Equatable, ManagedObjectConvertible {
    func toManagedObject(object: NSManagedObject) -> NSManagedObject? {
        if let height = height, let width = width {
            if let object = object as? MediaMetadataModelData {
                object.url = self.url
                object.format = self.format
                object.height = Int16(height)
                object.width = Int16(width)
            }
        }
        return object
    }
    
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
}
