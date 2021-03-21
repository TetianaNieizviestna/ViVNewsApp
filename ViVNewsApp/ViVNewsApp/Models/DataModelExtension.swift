//
//  DataModelExtension.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import Foundation

extension NewsModelData: PlainObjectConvertible {
    typealias PlainObject = NewsModel
    
    func toPlainObject() -> NewsModel {
        var mediaSet: [MediaModel] = []
        self.media?.allObjects.forEach{ item in
            if let element = item as? MediaModelData {
                mediaSet.append(element.toPlainObject())
            }
        }
        let newsModel = NewsModel.init(url: self.url,
                                  id: Int(self.id),
                                  source: self.source,
                                  publishedDate: self.publishedDate,
                                  section: self.section,
                                  subsection: self.subsection,
                                  nytdsection: self.nytdsection,
                                  adxKeywords: self.adxKeywords,
                                  byline: self.byline,
                                  type: self.type,
                                  title: self.title,
                                  abstract: self.abstract,
                                  media: mediaSet)
        return newsModel
    }
}

extension MediaModelData: PlainObjectConvertible {
    typealias PlainObject = MediaModel
    
    func toPlainObject() -> MediaModel {
        var metadataList: [MediaMetadataModel] = []
        self.mediaMetadata?.allObjects.forEach{ item in
            if let media = item as? MediaMetadataModelData {
                metadataList.append(media.toPlainObject())
            }
        }
        
        let mediaMetadata = MediaModel(
            type: self.type,
            subtype: self.subtype,
            caption: self.caption,
            copyright: self.copyright,
            mediaMetadata: metadataList
        )

        return mediaMetadata
    }
}

extension MediaMetadataModelData: PlainObjectConvertible {
    typealias PlainObject = MediaMetadataModel
    
    func toPlainObject() -> MediaMetadataModel {
        let mediaMetadata = MediaMetadataModel(
            url: self.url,
            format: self.format,
            height: Int(self.height),
            width: Int(self.width)
        )

        return mediaMetadata
    }
}
