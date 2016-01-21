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
	
	let contentChanged: Dynamic<Bool>
	private var films = [Film]()
	private let moc: NSManagedObjectContext

	init(managedObjectContext moc: NSManagedObjectContext) {
		contentChanged = Dynamic(false)
		self.moc = moc
		super.init()
		fetchedResultsController.delegate = self
		self.fetch()
	}
	
	var numberOfSections: Int {
		return fetchedResultsController.sections?.count ?? 0
	}
	
	func numberOfFilmsInSection(section: Int) -> Int {
		let sections = fetchedResultsController.sections! as [NSFetchedResultsSectionInfo]
		guard (section >= 0 && section < sections.count) else {
			return 0
		}
		return sections[section].numberOfObjects
	}
	
	func film(indexPath: NSIndexPath) -> FilmModelProtocol? {
		if let film = fetchedResultsController.objectAtIndexPath(indexPath) as? Film {
			return film
		}
		return nil
	}
	
	// generate fetch request based on entity name and sort descriptor
	
	// if frc is nil then create frc using fetch request
	// else just 
	
//	private func fetchResultsController(fetchRequestEntityName: String, sortDescriptorKey: String) -> NSFetchedResultsController {
//		let fetchRequest = NSFetchRequest(entityName: fetchRequestEntityName)
//		let sortDesciptors = [NSSortDescriptor(key: sortDescriptorKey, ascending: true)]
//		fetchRequest.sortDescriptors = sortDesciptors
//		let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.moc, sectionNameKeyPath: nil, cacheName: nil)
//		return frc
//	}
	
	private lazy var fetchedResultsController: NSFetchedResultsController = {
		let fetchRequest = NSFetchRequest(entityName: ModelEntity.film)
		let sortDesciptors = [NSSortDescriptor(key: FilmModelEntityAttribute.title, ascending: true)]
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
		if let fetchedObjects = fetchedResultsController.fetchedObjects {
			films = fetchedObjects as? [Film] ?? []
		}
		contentChanged.value = true
	}
}
