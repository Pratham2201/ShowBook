//
//  LoginPresenter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation
import UIKit

protocol ILoginPresenter {
    
    func navigateToHome()
    
    func setUpAlertBox()
}

class LoginPresenter: ILoginPresenter {
    
    weak var output: LoginViewController?
    
    func navigateToHome() {
        output?.router.routeToHomeScreen()
    }
    
    func setUpAlertBox() {
        showAlertBox(alertBoxParameters: AlertBoxParamters(title: "Warning!", msg: "Invalid Username or Password", actions: [UIAlertAction(title: "Ok", style: .cancel)]), vc: output)
    }
}
