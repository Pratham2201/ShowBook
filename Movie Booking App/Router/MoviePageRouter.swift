//
//  MoviePageRouter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 24/04/23.
//

import Foundation

protocol IMoviePageRouter {
    
    func routeToSeatBooking()
}

class MoviePageRouter: IMoviePageRouter {
    
    weak var viewController: MoviePageViewController?
    
    func routeToSeatBooking() {
        guard let vc = getViewController(vc: "SeatBookingViewController") as? SeatBookingViewController else { return }
        vc.movieIndex = viewController?.movieIndex
        vc.selectedMovieDate = viewController?.selectedDate
        vc.seletecMovieHall = viewController?.selectedHall
        vc.selectedMovieTiming = viewController?.selectedTime
        viewController?.navigationController?.pushViewController( vc, animated: true)
    }
}
