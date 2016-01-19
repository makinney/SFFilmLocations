//
//  FilmModelProtocol.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/19/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation

protocol FilmModelProtocol {
	var movieTitle: String { get }
	var movieLocation: String { get }
	var movieReleaseYear: String { get }
}