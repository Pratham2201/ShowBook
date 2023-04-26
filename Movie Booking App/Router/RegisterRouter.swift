//
//  RegisterRouter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 21/04/23.
//

import Foundation

protocol IRegisterRouter {
    
    func popToLogin()
}

class RegisterRouter: IRegisterRouter {
    
    weak var viewController: RegisterViewController?
    
    func popToLogin() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
