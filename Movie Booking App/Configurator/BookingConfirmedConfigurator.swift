//
//  BookingConfirmedConfigurator.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

struct BookingConfirmedConfigurator {
    
    static func configure(viewController: BookingConfirmedViewController) {
        
        let presenter = BookingConfirmedPresenter()
        let interactor = BookingConfirmedInteractor()
        
        let router = BookingConfirmationRouter()
        
        presenter.output = viewController
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        viewController.output = interactor
        viewController.router = router
    }
}
