//
//  SFFilmMediator.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation
import CoreData
class SFFilmMediator {
	
	let filmUrl = "https://data.sfgov.org/resource/yitu-d5am.json"
	let managedObjectContext: NSManagedObjectContext
	
	init(managedObjectContext: NSManagedObjectContext){
		self.managedObjectContext = managedObjectContext
	}
	
	func loadFilmData() {
		WebService.getFilms(filmUrl) { (filmData) -> Void in
			guard let filmData = filmData else {
				print("could not get film data from site")
				return
			}
			do {
				let films = try NSJSONSerialization.JSONObjectWithData(filmData, options: .AllowFragments)
				self.createCoreData(films)
			} catch let error as NSError {
				print(error.description)
			}
		}
	}
	
	func createCoreData(filmJSON: AnyObject) {
		guard let filmsJSON = filmJSON as? [[String:AnyObject]] else {
			return
		}
		for filmJSON in filmsJSON {
			let _ = Film.create(filmJSON,managedObjectContext: managedObjectContext)
		}
	}
}