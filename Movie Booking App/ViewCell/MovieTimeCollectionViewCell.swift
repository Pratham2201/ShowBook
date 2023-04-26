//
//  MovieTimeCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 10/04/23.
//

import UIKit

class MovieTimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewMovieTimeItem: UIView!
    @IBOutlet weak var lblMovieTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMovieTimeItem.layer.borderColor = UIColor.blue.cgColor
        viewMovieTimeItem.layer.borderWidth = 0.6
        viewMovieTimeItem.layer.cornerRadius = 15
    }

}
