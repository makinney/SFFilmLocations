//
//  FilmsTableViewController.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/18/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {
	
	@IBAction func onSort(sender: UIBarButtonItem) {
		sort()
	}
	
	var viewModel: AllFilmsModelProtocol? {
		didSet {
			viewModel!.contentChanged.bind {
				[weak self] in
				self?.contentChanged($0)
			}
		}
	}
	let tableViewCellID = "FilmTableViewCell"

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 65
		title = "San Francisco Films"
	}
	
	func contentChanged(changed: Bool) {
		tableView.reloadData()
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return viewModel?.numberOfSections ?? 0
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else {
			return 0
		}
		return viewModel.numberOfFilmsInSection(section)
	}
	
	private func sort() {
		guard let modelsSortedState = viewModel?.sortedBy else {
			return
		}
		switch(modelsSortedState) {
		case FilmsModelSortBy.title:
			viewModel?.sort(FilmsModelSortBy.releaseYear, ascending: false)
		case FilmsModelSortBy.releaseYear:
			viewModel?.sort(FilmsModelSortBy.location, ascending: true)
		case FilmsModelSortBy.location:
			viewModel?.sort(FilmsModelSortBy.title, ascending: true)
		}
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCellID, forIndexPath: indexPath) as! FilmTableViewCell
		guard let viewModel = viewModel,
				let film = viewModel.film(indexPath) else {
			return cell
		}
		cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.whiteColor() : UIColor.lightGrayColor()
		
		switch(viewModel.sortedBy) {
		case FilmsModelSortBy.title:
			cell.topCellText = "Title: " + film.movieTitle
			cell.middleCellText = "Date: " + film.movieReleaseYear
			cell.bottomCellText = "Location: " + film.movieLocation
			
		case FilmsModelSortBy.location:
			cell.topCellText = "Location: " + film.movieLocation
			cell.middleCellText = "Title: " + film.movieTitle
			cell.bottomCellText = "Date: " + film.movieReleaseYear

		case FilmsModelSortBy.releaseYear:
			cell.topCellText = "Date: " + film.movieReleaseYear
			cell.middleCellText = "Location: " + film.movieLocation
			cell.bottomCellText = "Title: " + film.movieTitle
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return viewModel?.sectionTitle(section)
	}
}
