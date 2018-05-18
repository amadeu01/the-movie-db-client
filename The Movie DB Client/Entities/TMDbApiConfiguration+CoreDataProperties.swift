//
//  TMDbApiConfiguration+.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 17/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import CoreData

extension TMDbApiConfiguration {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TMDbApiConfiguration> {
        return NSFetchRequest<TMDbApiConfiguration>(entityName: "TMDbApiConfiguration");
    }
    
    @NSManaged public var baseUrl: String?
    @NSManaged public var secureBaseUrl: String?
    @NSManaged public var backdropSizes: [String]
    @NSManaged public var logoSizes: [String]
    @NSManaged public var posterSizes: [String]
    @NSManaged public var profileSizes: [String]
    @NSManaged public var stillSizes: [String]
    @NSManaged public var changeKeys: [String]
}
