//
//  PersistentStoreCoordinatorFactory.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 25/07/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import CoreData
import UIKit

final class PersistenceStoreCoordinatorFactory {
    static func make() -> NSPersistentStoreCoordinator? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.persistentStoreCoordinator
        }
        return nil
    }
}
