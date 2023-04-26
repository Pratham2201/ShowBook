//
//  MenuConfigurator.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

struct MenuConfigurator {
    
    static func configure(viewController: MenuViewController) {
        
        let presenter = MenuPresenter()
        let interactor = MenuInteractor()
        
        let worker = MenuWorker()
        let router = MenuRouter()
        
        presenter.output = viewController
        
        interactor.output = presenter
        interactor.worker = worker
        
        router.viewController = viewController
        
        viewController.output = interactor
        viewController.router = router
    }
}
