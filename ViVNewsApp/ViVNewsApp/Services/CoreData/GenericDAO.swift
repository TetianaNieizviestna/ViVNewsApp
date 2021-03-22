//
//  GenericDAO.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import CoreData
import Foundation

protocol ManagedObjectConvertible {
    func toManagedObject(object: NSManagedObject) -> NSManagedObject?
}

protocol PlainObjectConvertible: NSManagedObject {
    associatedtype PlainObject
    func toPlainObject() -> PlainObject
}

class GenericDAO<T: ManagedObjectConvertible, M: PlainObjectConvertible>: DataAccessObject {
    typealias DataObjectType = T

    var dataHelper: CoreDataHelper<M>

    init(dataHelper: CoreDataHelper<M>) {
        self.dataHelper = dataHelper
    }

    func createManagedObject(article: T) -> NSManagedObject? {
        if let record = dataHelper.addRecord(M.self) {
            return article.toManagedObject(object: record)
        }
        return nil
    }

    func create(articles: [T], _ completion: @escaping () -> Void) {
        for article in articles {
            if let record = dataHelper.addRecord(M.self) {
                _ = article.toManagedObject(object: record)
            }
        }
    }
    
    func delete(properties: [String], values: [String]) {
        let predicate = self.buildAndPredicate(properties, values)
        self.dataHelper.context.perform {
            let records = self.dataHelper.query(M.self, search: predicate)
            if let record = records.first {
                self.dataHelper.deleteRecord(record)
                self.dataHelper.saveDatabase()
            }
        }
    }
    
    func getAll(completion: @escaping ([T]?) -> Void) {
        dataHelper.context.perform {
            let records = self.dataHelper.allRecords(M.self)
            let parts = records.map{ $0.toPlainObject() } as? [T]
            completion(parts)
        }
    }
    
    func get(properties: [String], values: [String], completion: @escaping ([T]?) -> Void) {
        let predicate = self.buildAndPredicate(properties, values)
        let records = self.dataHelper.query(M.self, search: predicate)
        let entities = records.map { record -> M.PlainObject in
            return record.toPlainObject()
        }
        completion(entities as? [T])
    }

    func update(article: T, predicate: NSPredicate?) {
        dataHelper.context.perform {
            guard let record = self.dataHelper.query(M.self, search: predicate).first else {
                return
            }
            
            _ = article.toManagedObject(object: record)
            self.dataHelper.saveDatabase()
        }
    }
    
    func deleteAll() {
        dataHelper.context.perform {
            self.dataHelper.deleteRecords(M.self)
            self.dataHelper.saveDatabase()
        }
    }
}
