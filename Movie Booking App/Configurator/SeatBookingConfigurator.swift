//
//  SeatBookingConfigurator.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

struct SeatBookingConfigurator {
    
    static func configure(viewController: SeatBookingViewController) {
        
        let presenter = SeatBookingPresenter()
        let interactor = SeatBookingInteractor()
        
        let router = SeatBookingRouter()
        
        presenter.output = viewController
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        viewController.output = interactor
        viewController.router = router
    }
}
