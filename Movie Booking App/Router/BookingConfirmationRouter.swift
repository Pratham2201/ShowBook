//
//  BookingConfirmationRouter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 22/04/23.
//

import Foundation

protocol IBookingConfirmationRouter {
    
    func routeToHome()
}

class BookingConfirmationRouter: IBookingConfirmationRouter {
    
    weak var viewController: BookingConfirmedViewController?
    
    func routeToHome() {
        viewController?.navigationController!.popToViewController((viewController?.navigationController?.viewControllers[0])!, animated: true)
    }
}
