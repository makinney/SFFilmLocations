//
//  FilmTableViewCell.swift
//  SFFilmLocations
//
//  Created by Michael Kinney on 1/19/16.
//  Copyright © 2016 makinney. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

	@IBOutlet weak var filmName: UILabel!
	@IBOutlet weak var releaseDate: UILabel!
	@IBOutlet weak var location: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	var topCellText: String {
		set(value) {
			filmName.text = value
		}
		get {
			return filmName.text ?? ""
		}
	}
	
	var middleCellText: String {
		set(value) {
			releaseDate.text = value
		}
		get {
			return releaseDate.text ?? ""
		}
	}
		
	var bottomCellText: String {
		set(value) {
			location.text = value
		}
		get {
			 return location.text ?? ""
		}
	}
	
}
