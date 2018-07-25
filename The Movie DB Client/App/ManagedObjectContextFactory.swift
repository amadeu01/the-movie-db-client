//
//  ManagedObjectModelFactory.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 25/07/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import CoreData

final class ManagedObjectContextFactory {
    static func make() -> NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            return appDelegate.persistentContainer.viewContext
        }
        return nil
    }
}
