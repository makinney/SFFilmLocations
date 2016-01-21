//
//  AllFilmsModelProtocol.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/19/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation

enum FilmsModelSortBy: String {
	case title = "title"
	case location = "location"
	case releaseYear = "releaseYear"
}

protocol AllFilmsModelProtocol {
	var contentChanged: Dynamic<Bool> { get }
	func film(indexPath: NSIndexPath) -> FilmModelProtocol?
	var numberOfSections: Int { get }
	func numberOfFilmsInSection(section: Int) -> Int
	func sectionTitle(section: Int) -> String
	func sort(sortBy: FilmsModelSortBy, ascending: Bool)
	var sortedBy: FilmsModelSortBy { get }
}