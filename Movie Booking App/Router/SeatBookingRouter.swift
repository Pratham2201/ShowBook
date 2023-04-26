//
//  SeatBookingRouter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation
import UIKit

protocol ISeatBookingRouter {
    
    func routeToBookingConfirmed(vc: UIViewController)
}

class SeatBookingRouter: ISeatBookingRouter {
    
    weak var viewController: SeatBookingViewController?
    
    func routeToBookingConfirmed(vc: UIViewController) {
        viewController?.navigationController?.pushViewController( vc, animated: false)
    }
}
