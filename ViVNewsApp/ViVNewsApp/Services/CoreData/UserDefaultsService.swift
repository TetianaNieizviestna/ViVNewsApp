//
//  UserDefaultsService.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 22.03.2021.
//

import Foundation
enum UserDefaultsService {}

// MARK: UserDefaultsService for show Onboarding when first enter the app
extension UserDefaultsService {
    static let key = "ViV/NewsModels"
    
    static func saveFavourites(newsModels: [NewsModel]) {
//        UserDefaults.standard.set(newsModels, forKey: UserDefaultsService.key)
//        UserDefaults.standard.synchronize()
        
        UserDefaultsService.saveData(key: UserDefaultsService.key, object: newsModels)
    }
    
    static func getFavourites() -> [NewsModel] {
//        let data = UserDefaults.standard.value(forKey: UserDefaultsService.key) as? [NewsModel]
//        return data ?? []
        
        let data = UserDefaultsService.getData(for: UserDefaultsService.key, type: [NewsModel].self)
        return data ?? []
    }
 
    static func saveData<T: Codable>(key: String, object: T) {
        if let data = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }

    static func getData<T: Codable>(for key: String, type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
}
