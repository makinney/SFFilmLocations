//
//  AllFilmsModel.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/19/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation
import CoreData

class AllFilmsModel: NSObject, AllFilmsModelProtocol {
	
	let filmsChanged: Dynamic<Bool>
	var numberOfFilms : Int {
		return films.count
	}
	func film(index: Int) -> FilmModelProtocol? {
		guard index > 0 && index < films.count else {
			return nil
		}
		return films[index]
	}
	
	private var films = [Film]()
	private let moc: NSManagedObjectContext
	
	init(managedObjectContext moc: NSManagedObjectContext) {
		filmsChanged = Dynamic(false)
		self.moc = moc
		super.init()
		fetchedResultsController.delegate = self
		self.fetch()
	}
	
	private lazy var fetchedResultsController: NSFetchedResultsController = {
		let fetchRequest = NSFetchRequest(entityName: ModelEntity.film)
		let sortDesciptors = [NSSortDescriptor(key: FilmModelAttribute.title, ascending: false)]
		fetchRequest.sortDescriptors = sortDesciptors
		let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.moc, sectionNameKeyPath: nil, cacheName: nil)
		
		return frc
	}()
	
	private func fetch() {
		do {
			try fetchedResultsController.performFetch()
			if let fetchedObjects = fetchedResultsController.fetchedObjects {
				films = fetchedObjects as? [Film] ?? []
			}
		} catch {
			print("\(__FUNCTION__) fetchedResultsController exception")
		}
	}
}

extension AllFilmsModel: NSFetchedResultsControllerDelegate {
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		filmsChanged.value = true
		print("data changed")
		if let fetchedObjects = fetchedResultsController.fetchedObjects {
			films = fetchedObjects as? [Film] ?? []
			print("fetched \(films.count) films")
		}
	}
}
