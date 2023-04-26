//
//  Movie.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 13/04/23.
//

import Foundation
import UIKit

struct Movie: Codable {
    let title: String
    let year: String
    let runtime: String
    let genre: String
    let plot: String
    let imdbRating: String
    let images: [String]
    let released: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case plot = "Plot"
        case imdbRating
        case images = "Images"
    }
}

struct User: Codable {
    let name: String
    let email: String
    let password: String
    var bookings: [Booking] = []
}

struct Booking: Codable {
    let movieIndex: Int
    let movieTiming: Date
    let movieDate: Date
    let movieHall: String
    let movieSeats: [Seat]
    let bookingAmount: Int
}

struct Seat: Hashable, Codable {
    let column: Int
    let row: Int
}

func showAlertBox(alertBoxParameters: AlertBoxParamters, vc: UIViewController?) {
    let alert = UIAlertController(title: alertBoxParameters.title , message: alertBoxParameters.msg, preferredStyle: .alert)
    for action in alertBoxParameters.actions {
        alert.addAction(action)
    }
    vc?.present(alert, animated: true, completion: nil)
}
