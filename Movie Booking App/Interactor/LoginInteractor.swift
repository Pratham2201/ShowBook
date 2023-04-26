//
//  LoginInteractor.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation

protocol ILoginInteractor {
    
    func validateUser(userEmail: String, userPassword: String)
}

class LoginInteractor: ILoginInteractor {
    
    var output: ILoginPresenter?
    var worker: ILoginWorker?
    
    func validateUser(userEmail: String, userPassword: String) {
        for userIndex in 0..<users.count {
            if( users[userIndex].email == userEmail && users[userIndex].password == userPassword ) {
                worker?.setUpActiveUser(userIndex: userIndex)
                output?.navigateToHome()
                break
            }
        }
        output?.setUpAlertBox()
    }
}
