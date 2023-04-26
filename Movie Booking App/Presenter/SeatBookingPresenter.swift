//
//  SeatBookingPresenter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation
import UIKit

protocol ISeatBookingPresenter {
    
    func setUpBookingAlertBox(passingParameters: (booking: Booking, key: String, hall: [[Int]])?)
    
    func getSeatBookingKey(key: String, hall: [[Int]])
}

class SeatBookingPresenter: ISeatBookingPresenter {
    
    weak var output: SeatBookingViewController?
    
    func setUpBookingAlertBox(passingParameters: (booking: Booking, key: String, hall: [[Int]])? = nil) {
        var alertBoxParameter: AlertBoxParamters? = nil
        if((passingParameters) != nil) {
             alertBoxParameter = AlertBoxParamters(title: "Warning!", msg: "Do you want to confirm booking?",
                                                       actions: [UIAlertAction(title: "Confirm", style: .default, handler: {(_) in
                guard let vc = getViewController(vc: "BookingConfirmedViewController") as? BookingConfirmedViewController else { return }
                vc.booking = passingParameters?.booking
                vc.seatBookingKey = passingParameters?.key
                vc.hallSelected = passingParameters!.hall
                self.output?.router?.routeToBookingConfirmed(vc: vc)}),
                                                                 UIAlertAction(title: "Cancel", style: .cancel) ])
        } else {
            alertBoxParameter = AlertBoxParamters(title: "Warning", msg: "No seats selected", actions: [UIAlertAction(title: "OK", style: .cancel)])
        }
        output?.confirmBooking(alertBoxParamters: alertBoxParameter!)
    }
    
    func getSeatBookingKey(key: String, hall: [[Int]]) {
        output?.getKeyAndHall(key: key, hall: hall)
    }
}
