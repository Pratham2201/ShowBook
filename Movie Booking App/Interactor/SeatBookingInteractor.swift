//
//  SeatBookingInteractor.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

protocol ISeatBookingInteractor {
    
    func bookSeats(selectedMovie: Int, selectedDate: Int, selectedTime: Int, selectedHall: Int, selectedSeats: Set<Seat>, hall: [[Int]])
    
    func createSeatBookingKey(selectedMovie: Int, selectedDate: Int, selectedTime: Int, selectedHall: Int) -> String
    
    func setBookingKeyAndHall(selectedMovie: Int, selectedDate: Int, selectedTime: Int, selectedHall: Int)
}

class SeatBookingInteractor: ISeatBookingInteractor {
    
    var output: ISeatBookingPresenter?
    let price = 15
    
    func bookSeats(selectedMovie: Int, selectedDate: Int, selectedTime: Int, selectedHall: Int, selectedSeats: Set<Seat>, hall: [[Int]]) {
        if(selectedSeats.count>0) {
            let booking = Booking(movieIndex: selectedMovie, movieTiming: movieTimings[selectedTime], movieDate: upcomingMovieDates[selectedDate]!, movieHall: movieHalls[selectedHall], movieSeats: Array(selectedSeats), bookingAmount: (selectedSeats.count*price))
            let seatBookingKey = createSeatBookingKey(selectedMovie: selectedMovie, selectedDate: selectedDate, selectedTime: selectedTime, selectedHall: selectedHall)
            output?.setUpBookingAlertBox(passingParameters: (booking: booking, key: seatBookingKey, hall: hall))
        } else {
            output?.setUpBookingAlertBox(passingParameters: nil)
        }
    }
    
    func setBookingKeyAndHall(selectedMovie: Int, selectedDate: Int, selectedTime: Int, selectedHall: Int) {
        let key = createSeatBookingKey(selectedMovie: selectedMovie, selectedDate: selectedDate, selectedTime: selectedTime, selectedHall: selectedHall)
        output?.getSeatBookingKey(key: key, hall: seatBooking[key] ?? defaultSeatArrangement)
    }
    
    func createSeatBookingKey(selectedMovie: Int, selectedDate: Int, selectedTime: Int, selectedHall: Int) -> String {
        let keyDateFormatter = DateFormatter()
        var key = moviesData[selectedMovie].title
        key += movieHalls[selectedHall]
        keyDateFormatter.dateFormat = "MM dd"
        key += keyDateFormatter.string(from: upcomingMovieDates[selectedDate]!)
        keyDateFormatter.dateFormat = "hh mm a"
        key += keyDateFormatter.string(from: movieTimings[selectedTime])
        return key
    }
}
