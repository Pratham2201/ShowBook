//
//  HomeConfigurator.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

struct HomeConfigurator {
    
    static func configure(viewController: HomeViewController) {
        
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        let worker = HomeWorker()
        let router = HomeRouter()
        
        presenter.output = viewController
        
        interactor.output = presenter
        interactor.worker = worker
        
        router.viewController = viewController
        
        viewController.output = interactor
        viewController.router = router
    }
}
