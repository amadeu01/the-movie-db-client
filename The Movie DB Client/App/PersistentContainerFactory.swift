//
//  PersistentContainerFactory.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 10/08/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import CoreData

final class PersistentContainerFactory {
    private static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "The_Movie_DB_Client")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    static func make() -> NSPersistentContainer {
        return persistentContainer
    }
}
