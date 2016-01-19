//
//  AllFilmsModelProtocol.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/19/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation

protocol AllFilmsModelProtocol {
	var filmsChanged: Dynamic<Bool> { get }
	func film(index: Int) -> FilmModelProtocol?
	var numberOfFilms: Int { get }
}