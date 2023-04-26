//
//  BookingTableViewCell.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import UIKit

class BookingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblSeatsBooked: UILabel!
    @IBOutlet weak var lblMovieHall: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    @IBOutlet weak var lblMovieTime: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgMovie.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
