//
//  CoreDataServices.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import Foundation
import CoreData

enum CoreDataServices {}

extension CoreDataServices {
    private static let dataController = DataController()
    static var helper: CoreDataHelper<NSManagedObject> {
        if Thread.isMainThread {
            return CoreDataHelper.init(context: CoreDataServices.dataController.backgroundContext)
        } else {
            return CoreDataHelper.init(context: CoreDataServices.dataController.backgroundContext)
        }
    }
    
    private static func getGeneric<T, M>(_ inputType: T.Type, _ resultType: M.Type) -> GenericDAO<T, M> {
        GenericDAO<T, M>.init(
            dataHelper: CoreDataHelper<M>.init(
                context: CoreDataServices.helper.context
            )
        )
    }
    
    static func read<T: ManagedObjectConvertible, M: PlainObjectConvertible>(_ type: M.Type, _ resultType: T.Type, completion: @escaping ([T]?) -> Void){
        self.getGeneric(T.self, M.self).getAll(completion: completion)
    }
    
    static func create<T: ManagedObjectConvertible, M: PlainObjectConvertible>(_ info: T, _ reseltType: M.Type) {
        let object = getObject(info, M.self)
        print("create object - \(String(describing: object))")
        CoreDataServices.helper.saveDatabase()
    }
    
    static func delete<T: ManagedObjectConvertible, M: PlainObjectConvertible>(_ info: T, _ reseltType: M.Type) {
        switch info {
        case let newsModel as NewsModel:
            if let id = newsModel.id {
                self.getGeneric(T.self, M.self).delete(properties: ["id"], values: ["\(id)"])
            }
        default:
            return
        }
    }
    
    static func update<T: ManagedObjectConvertible, M: PlainObjectConvertible>(_ info: T, _ reseltType: M.Type) {
        switch info {
        case let newsModel as NewsModel:
            if let id = newsModel.id {
                self.getGeneric(T.self, M.self).update(article: info, predicate: NSPredicate(format: "id == %@", "\(id)"))
            }
        default:
            return
        }
    }
    
    static func getObject<T: ManagedObjectConvertible, M: PlainObjectConvertible>(_ info: T, _ reseltType: M.Type) -> M? {
        if let record = self.getGeneric(T.self, M.self).createManagedObject(article: info) as? M {
            return record
        }
        return nil
    }
}
