//
//  BookingConfirmedInteractor.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 23/04/23.
//

import Foundation

protocol IBookingConfirmedInteractor {
    
    func saveBookedSeats(hallSelected: [[Int]], key: String)
    
    func saveBookingToUser(booking: Booking)
}

class BookingConfirmedInteractor: IBookingConfirmedInteractor {
    
    var output: IBookingConfirmedPresenter?
    
    func saveBookedSeats(hallSelected: [[Int]], key: String) {
        var hall = hallSelected
        DispatchQueue.global(qos: .background).async {
            for col in 0..<hallSelected.count {
                for row in 0..<hallSelected[col].count {
                    if(hallSelected[col][row] == 2) {
                        hall[col][row] = 3
                    }
                }
            }
            seatBooking[key] = hall
        }
        output?.holdBookingConfirmedDisplay()
    }
    
    func saveBookingToUser(booking: Booking) {
        activeUser.bookings.append(booking)
    }
}
