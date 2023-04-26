//
//  LoginConfigurator.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation

struct LoginConfigurator {
    
    static func configure(viewController: LoginViewController) {
        
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        
        let worker = LoginWorker()
        let router = LoginRouter()
        
        presenter.output = viewController
        
        interactor.output = presenter
        interactor.worker = worker
        
        router.viewController = viewController
        
        viewController.output = interactor
        viewController.router = router
    }
}
