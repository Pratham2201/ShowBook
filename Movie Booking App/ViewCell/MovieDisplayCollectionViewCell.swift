//
//  MovieDisplayCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 06/04/23.
//

import UIKit

class MovieDisplayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(posterName: String, movie: Movie) {
        ivMovie.image = UIImage(named: posterName)
        ivMovie.layer.cornerRadius = 5
        lblMovieName.text = movie.title
        lblMovieTime.text = movie.runtime
    }

}
