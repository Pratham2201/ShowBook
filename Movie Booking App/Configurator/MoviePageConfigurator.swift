//
//  MoviePageConfigurator.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

struct MoviePageConfigurator {
    
    static func configure(viewController: MoviePageViewController) {

        let router = MoviePageRouter()
        
        router.viewController = viewController
        viewController.router = router
    }
}
