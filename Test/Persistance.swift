//
//  Persistance.swift
//  Test
//
//  Created by Padma Priya on 4/18/21.
//

import CoreData


struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Test")
        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }
    }
}
