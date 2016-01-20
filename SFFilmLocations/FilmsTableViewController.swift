//
//  FilmsTableViewController.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {

	let tableViewCellID = "FilmTableViewCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 65
		title = "SF Film Locations"
	}
	
	var viewModel: AllFilmsModelProtocol? {
		didSet {
			viewModel!.contentChanged.bind {
				[weak self] in
				self?.contentChanged($0)
			}
		}
	}
	
	func contentChanged(changed: Bool) {
		tableView.reloadData()
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else {
			return 0
		}
		return viewModel.numberOfFilms
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCellID, forIndexPath: indexPath) as! FilmTableViewCell
		guard let viewModel = viewModel,
				let film = viewModel.film(indexPath.row) else {
			return cell
		}
		cell.filmName.text = film.movieTitle
		cell.releaseDate.text = film.movieReleaseYear
		cell.location.text = film.movieLocation
		cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.whiteColor() : UIColor.lightGrayColor()
		return cell
	}
	
	

	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

}
