//
//  DropdownTableViewCell.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 11/04/23.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDropdownOption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
