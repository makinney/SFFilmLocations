//
//  Film+CoreDataProperties.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Film {

    @NSManaged var title: String?
    @NSManaged var location: String?
    @NSManaged var releaseYear: String?

}
