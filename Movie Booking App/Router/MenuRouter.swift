//
//  MenuRouter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation

protocol IMenuRouter {
    
    func routeToUser()
    
    func routeToMoviePage(movieIndex: Int)
}

class MenuRouter: IMenuRouter {
    
    weak var viewController: MenuViewController?
    
    func routeToUser() {
        viewController?.navigationController?.pushViewController(getViewController(vc: "UserViewController"), animated: true)
    }
    
    func routeToMoviePage(movieIndex: Int) {
        guard let vc = getViewController(vc: "MoviePageViewController") as? MoviePageViewController else { return }
        vc.movieIndex = movieIndex
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
