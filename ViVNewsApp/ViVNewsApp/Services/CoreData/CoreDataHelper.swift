//
//  CoreDataHelper.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import CoreData
import Foundation

class CoreDataHelper<T: NSManagedObject> {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addRecord(_ type: T.Type) -> T? {
        let entityName = T.entity().name ?? ""
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        if let uEntity = entity {
            let record = T(entity: uEntity, insertInto: context)
            return record
        }
        
        return nil
    }
    
    func recordsInTable(_ type: T.Type) -> Int {
        let recs = allRecords(T.self)
        return recs.count
    }
    
    func allRecords(_ type: T.Type, sort: NSSortDescriptor? = nil) -> [T] {
        let request = T.fetchRequest()
        do {
            if let results = try context.fetch(request) as? [T] {
                return results
            } else {
               return []
            }
        } catch {
            print("Error with request: \(error)")
            return []
        }
    }
    
    func query(_ type: T.Type, search: NSPredicate?, sort: NSSortDescriptor? = nil, multiSort: [NSSortDescriptor]? = nil) -> [T] {
        let request = T.fetchRequest()
        if let predicate = search {
            request.predicate = predicate
        }
        
        if let sortDescriptors = multiSort {
            request.sortDescriptors = sortDescriptors
        } else if let sortDescriptor = sort {
            request.sortDescriptors = [sortDescriptor]
        }
        
        do {
            if let results = try context.fetch(request) as? [T] {
                return results
            } else {
               return []
            }
        } catch {
            print("Error with request: \(error)")
            return []
        }
    }
    
    func deleteRecord(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    func deleteRecords(_ type: T.Type, search: NSPredicate? = nil) {
        let results = query(T.self, search: search)
        
        for record in results {
            context.delete(record)
        }
    }
    
    func saveDatabase() {
        do {
            try context.save()
            
            let parent = context.parent
            parent?.performAndWait {
                do {
                    try parent?.save()
                } catch {
                    print("Error saving database: \(error)")
                }
            }
        } catch {
            print("Error saving database: \(error)")
        }
    }
}
