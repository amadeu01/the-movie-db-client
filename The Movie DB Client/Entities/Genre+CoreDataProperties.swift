//
//  Genre+.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 15/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import CoreData

extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var name: String?

    public var remoteId: Int32? {
        get {
            willAccessValue(forKey: "remoteId")
            defer { didAccessValue(forKey: "remoteId") }

            return primitiveValue(forKey: "remoteId") as? Int32
        }
        set {
            willChangeValue(forKey: "remoteId")
            defer { didChangeValue(forKey: "remoteId") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "remoteId")
                return
            }
            setPrimitiveValue(value, forKey: "remoteId")
        }
    }
}
