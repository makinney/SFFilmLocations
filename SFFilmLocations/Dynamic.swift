//
//  Dynamic.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/19/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation

class Dynamic<T> {
	typealias Listener = T -> Void
	var listener: Listener?
	
	func bind(listener: Listener?) {
		self.listener = listener
	}
	
	func bindAndFire(listener: Listener?) {
		self.listener = listener
		listener?(value)
	}
	
	var value: T {
		didSet {
			listener?(value)
		}
	}
	
	init(_ v: T) {
		value = v
	}
}