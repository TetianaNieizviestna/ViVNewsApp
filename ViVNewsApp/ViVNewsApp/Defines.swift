//
//  Defines.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//

import Foundation

struct Defines {
    enum API {
        static let appId = "bee8b547-c5d0-474c-bcdf-a5b1adfb3984"
        static let apiKey = "apHgxARkmZpAKiFbsgYYn1ho7S7TPYLb"
        static let secret = "2w7Jor7zAnzqXTqR"
        
        static var baseURL: URL {
            return URL(string: "https://api.nytimes.com/svc/mostpopular/v2/")!
        }
    }
}
