//
//  MenuPresenter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation
import UIKit

protocol IMenuPresenter {
    
    func setUpImageForCell(imageIndex: Int)
    
    func setUpFilteredMovies(filteredMovies: [(movie: Movie, movieIndex: Int, imageData: Data)])
    
    func setUpFilterAlertBox(actions: [UIAlertAction])
}

class MenuPresenter: IMenuPresenter {
    
    weak var output: MenuViewController?
    
    func setUpFilterAlertBox(actions: [UIAlertAction]) {
        showAlertBox(alertBoxParameters: AlertBoxParamters(title: "Filters", msg: "Choose from options below to filter", actions: actions), vc: output)
    }
    
    func setUpImageForCell(imageIndex: Int) {
        DispatchQueue.main.async {
            self.output?.setImage(imageIndex: imageIndex)
        }
    }
    
    func setUpFilteredMovies(filteredMovies: [(movie: Movie, movieIndex: Int, imageData: Data)]) {
        output?.reloadCVBrowse(filteredMovies: filteredMovies)
    }
}
