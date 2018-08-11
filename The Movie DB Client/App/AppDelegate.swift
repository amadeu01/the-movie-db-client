//
//  AppDelegate.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 03/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let movieList = MovieListWireFrame.createMovieListModule()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = movieList
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = PersistentContainerFactory.make().viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
