//
//  RegisterConfigurator.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

struct RegisterConfigurator {
    
    static func configure(viewController: RegisterViewController) {
        
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        
        let router = RegisterRouter()
        
        presenter.output = viewController
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        viewController.output = interactor
        viewController.router = router
    }
}
