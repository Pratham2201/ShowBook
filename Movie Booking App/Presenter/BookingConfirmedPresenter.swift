//
//  BookingConfirmedPresenter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 23/04/23.
//

import Foundation

protocol IBookingConfirmedPresenter {
    
    func holdBookingConfirmedDisplay()
}

class BookingConfirmedPresenter: IBookingConfirmedPresenter {
    
    weak var output: BookingConfirmedViewController?
    
    func holdBookingConfirmedDisplay() {
        output?.pauseBookingConfirmed()
    }
}
