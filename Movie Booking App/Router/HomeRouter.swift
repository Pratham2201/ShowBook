//
//  HomeRouter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation

protocol IHomeRouter {
    
    func routeToUser()
    
    func routeToMenu()
    
    func routeToMoviePage(movieIndex: Int)
}

class HomeRouter: IHomeRouter {
    
    weak var viewController: HomeViewController?
    
    func routeToUser() {
        viewController?.navigationController?.pushViewController(getViewController(vc: "UserViewController"), animated: true)
    }
    
    func routeToMenu() {
        viewController?.navigationController?.pushViewController(getViewController(vc: "MenuViewController"), animated: true)
    }
    
    func routeToMoviePage(movieIndex: Int) {
        guard let vc = getViewController(vc: "MoviePageViewController") as? MoviePageViewController else { return }
        vc.movieIndex = movieIndex
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
