//
//  DataSource.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 13/04/23.
//

import Foundation

var moviesData: [Movie] = []

var imagesData: [Data] = []

let movieJSON_URL = "https://pratham2201.github.io/Data/MovieJSON.json"

let movieTimings: [Date] = [ Calendar.current.date(from: DateComponents(hour: 10, minute: 30))!,
                            Calendar.current.date(from: DateComponents(hour: 13, minute: 30))!,
                            Calendar.current.date(from: DateComponents(hour: 16, minute: 00))!,
                            Calendar.current.date(from: DateComponents(hour: 19, minute: 30))!,
                            Calendar.current.date(from: DateComponents(hour: 22, minute: 30))!]

let movieHalls = ["Chhotu Maharaj Cine Cafe", "Cinepolis: Seasons Mall", "PVR ICON: The Pavillion Pune", "City Pride: Kothrud", "INOX: Bund Garden Road", "E-Square ELITE: Xino Mall", "PVR: Pheonix Market City"]

let movieDates = [Calendar.current.date(byAdding: .day, value: 1, to: Date()),
                  Calendar.current.date(byAdding: .day, value: 1, to: Date()),
                  Calendar.current.date(byAdding: .day, value: 1, to: Date())]

let upcomingMovieDates = [Calendar.current.date(byAdding: .day, value: 0, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 1, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 2, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 3, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 4, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 5, to: Date()),
                          Calendar.current.date(byAdding: .day, value: 6, to: Date())]

let USERS_DATA_KEY = "UsersData"

var users: [User] = []

var seatBooking: [String: [[Int]]] = [:]

let seatsDateFormatter = DateFormatter()
let dateFormat = "MM dd hh mm a"

let USER_LOGIN_STATUS_KEY = "isUserLoggedIn"

let ACTIVE_USER_KEY = "activeUserKey"
let ACTIVE_USER_INDEX_KEY = "activeUserIndexKey"

var activeUser: User!

var activeUserIndex: Int!

let columnMap: [Int: String] = [0: "A", 1: "B", 2: "C", 3: "D", 4: "E", 5: "F", 6: "G", 7: "H", 8: "I", 9:"J", 10:"K", 11:"L"]

let defaultSeatArrangement = [[0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0],
                     [0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                     [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                     [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1],
                     [1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1]]
