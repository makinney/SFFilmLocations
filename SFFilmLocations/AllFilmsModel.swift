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
	private let fetchRequest: NSFetchRequest
	private let moc: NSManagedObjectContext

	init(managedObjectContext moc: NSManagedObjectContext) {
		contentChanged = Dynamic(false)
		self.moc = moc
		fetchRequest = NSFetchRequest(entityName: ModelEntity.film)
		super.init()
		sort(FilmsModelSortBy.title, ascending: true) // sorts and fetches
	}
	
	func film(indexPath: NSIndexPath) -> FilmModelProtocol? {
		if let film = fetchedResultsController.objectAtIndexPath(indexPath) as? Film {
			return film
		}
		return nil
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
	
	func sectionTitle(section: Int) -> String {
		let sectionsInfo = fetchedResultsController.sections! as [NSFetchedResultsSectionInfo]
		return sectionsInfo[section].name
	}
	
	func sort(sort: FilmsModelSortBy, ascending: Bool) {
		var sortDescriptorKey = FilmModelEntityAttribute.title
		switch (sort) {
		case FilmsModelSortBy.title:
			sortDescriptorKey = FilmModelEntityAttribute.title
		case FilmsModelSortBy.location:
			sortDescriptorKey = FilmModelEntityAttribute.location
		case FilmsModelSortBy.releaseYear:
			sortDescriptorKey = FilmModelEntityAttribute.releaseYear
		}
		let sortDesciptors = [NSSortDescriptor(key: sortDescriptorKey, ascending: ascending)]
		fetchRequest.sortDescriptors = sortDesciptors
		fetch()
	}
	
	private lazy var fetchedResultsController: NSFetchedResultsController = {
		let frc = NSFetchedResultsController(fetchRequest: self.fetchRequest, managedObjectContext: self.moc, sectionNameKeyPath: nil, cacheName: nil)
		frc.delegate = self
		return frc
	}()
	
	private func fetch() {
		do {
			try fetchedResultsController.performFetch()
		} catch {
			print("\(__FUNCTION__) fetchedResultsController exception")
		}
	}
}

extension AllFilmsModel: NSFetchedResultsControllerDelegate {
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		contentChanged.value = true
	}
}
