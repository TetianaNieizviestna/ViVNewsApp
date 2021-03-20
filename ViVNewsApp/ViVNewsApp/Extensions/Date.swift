//
//  Date.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//

import Foundation
enum DateFormat: String {
    case jsonDateMs = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case jsonDate = "yyyy-MM-dd'T'HH:mm:ss"
    case publishedDate = "yyyy-MM-dd"
    case apiTime = "dd/MM/yyyy HH:mm:ss"
    case printDate = "MMM dd, yyyy"
    case printMessageDate = "MMM d"
}

extension Date {
    static func getFormattedDateString(string: String) -> String {
        return getFormattedDate(inputFormat: .publishedDate , outputFormat: .printDate, string: string)
    }
    
    static func getMessageDateString(date: Date) -> String {
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.dateFormat = DateFormat.jsonDateMs.rawValue
        return dateFormatterResult.string(from: date)
    }
    
    static func getDate(from string: String) -> Date {
        if let date = getDate(by: .jsonDateMs, from: string) {
            return date
        } else if let date = getDate(by: .jsonDate, from: string) {
            return date
        } else if let date = getDate(by: .apiTime, from: string){
            return date
        } else {
            return Date()
        }
    }
    
    static func getDate(by format: DateFormat, from string: String) -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format.rawValue
        if let date = dateFormatterGet.date(from: string) {
            return date
        }
        return nil
        
    }
    
    static func getPrintMessageDate(date: Date) -> String {
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.dateFormat = DateFormat.printMessageDate.rawValue
        return dateFormatterResult.string(from: date)
    }
    
    static func getFormattedDate(inputFormat: DateFormat, outputFormat: DateFormat, string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = inputFormat.rawValue
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.dateFormat = outputFormat.rawValue
        if let date = dateFormatterGet.date(from: string) {
            return dateFormatterResult.string(from: date)
        } else {
            return ""
        }
    }
    
}
