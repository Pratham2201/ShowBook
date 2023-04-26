//
//  LoginRouter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation

protocol ILoginRouter {
    
    func routeToHomeScreen()
    func routeToRegisterScreen()
}

class LoginRouter: ILoginRouter {
    
    weak var viewController: LoginViewController?
    
    func routeToHomeScreen() {
        viewController?.navigationController?.setViewControllers([getViewController(vc: "HomeViewController")], animated: true)
    }
    
    func routeToRegisterScreen() {
        viewController?.navigationController?.pushViewController(getViewController(vc: "RegisterViewController"), animated: true)
    }
}
