//
//  BookingConfirmedViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 17/04/23.
//

import UIKit

class BookingConfirmedViewController: UIViewController {

    @IBOutlet weak var viewMovieDetails: UIView!
    @IBOutlet weak var viewBookingDetails: UIView!
    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var lblSeatsBooked: UILabel!
    @IBOutlet weak var lblMovieAmount: UILabel!
    @IBOutlet weak var lblMovieHall: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    @IBOutlet weak var lblMovieTime: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    
    var router: IBookingConfirmationRouter?
    var output: IBookingConfirmedInteractor?
    
    var booking: Booking!
    var seatBookingKey: String!
    var hallSelected: [[Int]] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        BookingConfirmedConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        BookingConfirmedConfigurator.configure(viewController: self)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBookings()
        output?.saveBookingToUser(booking: booking)
        output?.saveBookedSeats(hallSelected: hallSelected, key: seatBookingKey)
    }
}

extension BookingConfirmedViewController {
    func setUpBookings() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd"
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        var seats = ""
        for seat in booking.movieSeats {
            let seatName = columnMap[seat.column]!+String(seat.row)
            seats = seats + seatName + ","
        }
        seats.remove(at: seats.index(seats.endIndex, offsetBy: -1))
        
        lblSeatsBooked.text = seats
        lblMovieAmount.text = "$\(booking.bookingAmount)"
        lblMovieHall.text = booking.movieHall
        lblMovieDate.text = dateFormatter.string(from: booking.movieDate)
        lblMovieTime.text = timeFormatter.string(from: booking.movieTiming)
        lblMovieName.text = moviesData[booking.movieIndex].title
        ivMoviePoster.image = UIImage(data: imagesData[booking.movieIndex])
        
        viewMovieDetails.layer.cornerRadius = 20
        viewBookingDetails.layer.cornerRadius = 20
    }
    
    func pauseBookingConfirmed() {
        navigationController?.isNavigationBarHidden = true
        DispatchQueue.global(qos: .background).async {
            Thread.sleep(forTimeInterval: TimeInterval(1))
            DispatchQueue.main.async {
                self.navigationController?.isNavigationBarHidden = false
                self.router?.routeToHome()
            }
        }
    }
}
