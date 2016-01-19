//
//  WebService.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import Foundation

class WebService {
	
	class func getFilms(dataUrl: String, complete:(filmData: NSData?) -> Void) {
		guard let url = NSURL(string: dataUrl) else {
			complete(filmData: nil)
			return
		}
		let session = NSURLSession.sharedSession()
		let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
			guard let data = data, let _ = response where error == nil else {
				print(error)
				complete(filmData: nil)
				return
			}
			complete(filmData: data)
		}
		task.resume()
	}
}
