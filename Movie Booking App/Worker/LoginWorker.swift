//
//  LoginWorker.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation

protocol ILoginWorker {
    
    func setUpActiveUser(userIndex: Int)
}

class LoginWorker: ILoginWorker {
    
    func setUpActiveUser(userIndex: Int) {
        activeUser = users[userIndex]
        activeUserIndex = userIndex
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(users[userIndex]) {
            UserDefaults.standard.set(encoded, forKey: ACTIVE_USER_KEY)
            UserDefaults.standard.set(activeUserIndex, forKey: ACTIVE_USER_INDEX_KEY)
        }
        UserDefaults.standard.set(true, forKey: USER_LOGIN_STATUS_KEY)
    }
}
