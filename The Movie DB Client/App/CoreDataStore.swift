//
//  CoreData.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 17/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import CoreData

class CoreDataStore {

    static var persistentStoreCoordinator = PersistenceStoreCoordinatorFactory.make()

    static var managedObjectModel = ManagedObjectModelFactory.make()

    static var managedObjectContext = ManagedObjectContextFactory.make()
}
