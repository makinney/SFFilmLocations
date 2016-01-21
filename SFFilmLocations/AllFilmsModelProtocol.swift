//
//  AllFilmsModelProtocol.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/19/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation

//enum FilmsModelSort: String {
//	case byTitle
//	case byLocation
//	case byReleaseYear
//}

protocol AllFilmsModelProtocol {
	var contentChanged: Dynamic<Bool> { get }
	func film(indexPath: NSIndexPath) -> FilmModelProtocol?
	var numberOfSections: Int { get }
	func numberOfFilmsInSection(section: Int) -> Int
	
//	var sort: FilmsModelSort { set get }
}