//
//  Film.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation
import CoreData

class Film: NSManagedObject, FilmModelProtocol {
	class func create(json: [String:AnyObject], managedObjectContext moc: NSManagedObjectContext) -> Film? {
		if let film = NSEntityDescription.insertNewObjectForEntityForName(ModelEntity.film, inManagedObjectContext: moc) as? Film {
			film.title = json[FilmModelAttribute.title] as? String ?? ""
			film.location = json["locations"] as? String ?? ""
			film.releaseYear = json["release_year"] as? String ?? ""
			return film
		}
		return nil
	}
	
	var movieTitle: String {
		return self.title ?? ""
	}
	
	var movieLocation: String {
		return self.location ?? ""
	}
	
	var movieReleaseYear: String {
		return self.releaseYear ?? ""
	}
	
}
