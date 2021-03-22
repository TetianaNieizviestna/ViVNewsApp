//
//  DataController.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import CoreData
import UIKit


class DMPersistentContainer: NSPersistentContainer {}

class DataController {
    lazy var persistentContainer: DMPersistentContainer = {
        let container = DMPersistentContainer(name: "CoreDataModel")
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        return context
    }()

    init() {
        self.persistentContainer.loadPersistentStores { desc, error in
            if let err = error {
                fatalError("Error loading store \(desc): \(err)")
            }
        }
    }
}
