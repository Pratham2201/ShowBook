//
//  MovieCalendarCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 10/04/23.
//

import UIKit

class MovieCalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewCalendarItem: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewCalendarItem.layer.borderColor = UIColor.blue.cgColor
        viewCalendarItem.layer.borderWidth = 0.6
        viewCalendarItem.layer.cornerRadius = 10
    }

}
