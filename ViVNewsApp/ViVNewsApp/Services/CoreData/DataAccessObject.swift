//
//  DataAccessObject.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import CoreData
import Foundation

protocol DataAccessObject {
    associatedtype DataObjectType

    typealias DataTypeCompletion = (_ result: [DataObjectType]?) -> Void

    func create(articles: [DataObjectType], _ completion: @escaping () -> Void)
    func createManagedObject(article: DataObjectType) -> NSManagedObject?
    func getAll(completion: @escaping DataTypeCompletion)
    func get(properties: [String], values: [String], completion: @escaping DataTypeCompletion)
    func update(article: DataObjectType, predicate: NSPredicate?)
    func deleteAll()
    func delete(properties: [String], values: [String])
}

extension DataAccessObject {
    func buildAndPredicate(_ properties: [String], _ values: [String]) -> NSCompoundPredicate {
        var andPredicate: [NSPredicate] = []

        for (property, value) in zip(properties, values) {
            let predicate = NSPredicate(format: "ANY %K == %@", property, value)
            andPredicate.append(predicate)
        }

        return NSCompoundPredicate(andPredicateWithSubpredicates: andPredicate)
    }
}
