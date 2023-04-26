//
//  MovieCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 04/04/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var constraintImgHeight: NSLayoutConstraint!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var viewPosterImg: UIView!
    
    func setUpPoster(imgHeight: CGFloat, alpha: CGFloat, zPosition: CGFloat) {
        imgMoviePoster.layer.cornerRadius = 20
        constraintImgHeight.constant = imgHeight
        imgMoviePoster.alpha = alpha
        self.layer.zPosition = zPosition
    }
    
}
