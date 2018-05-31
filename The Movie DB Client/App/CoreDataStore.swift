//
//  CoreData.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 17/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataStore {

    static var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.persistentStoreCoordinator
        }
        return nil
    }

    static var managedObjectModel: NSManagedObjectModel? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.managedObjectModel
        }
        return nil
    }

    static var managedObjectContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            return appDelegate.persistentContainer.viewContext
        }
        return nil
    }

}
