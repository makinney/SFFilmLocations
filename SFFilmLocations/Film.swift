//
//  Film.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation
import CoreData

class Film: NSManagedObject {
	class func create(json: [String:AnyObject], managedObjectContext moc: NSManagedObjectContext) -> Film? {
		if let film = NSEntityDescription.insertNewObjectForEntityForName(ModelEntity.film, inManagedObjectContext: moc) as? Film {
			film.title = json["title"] as? String ?? "Unknown"
			film.location = json["locations"] as? String ?? "Unknown"
			film.releaseYear = json["release_year"] as? String ?? "Unknown"
			return film
		}
		return nil
	}
}

extension Film: FilmModelProtocol {

	var movieTitle: String {
		return self.title ?? "Unknown"
	}
	
	var movieLocation: String {
		return self.location ?? "Unknown"
	}
	
	var movieReleaseYear: String {
		return self.releaseYear ?? "Unknown"
	}
}
