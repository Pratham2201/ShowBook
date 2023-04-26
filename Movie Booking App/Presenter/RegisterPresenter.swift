//
//  RegisterPresenter.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation
import UIKit

protocol IRegisterPresenter {
    
    func setUpErrorLabel(errorLabel: EntryLabels, isErrorPresent: Bool, _ errorType: PasswordErrorType?)
    
    func setUpAlertBox()
    
    func nvaigateToLogin()
}

class RegisterPresenter: IRegisterPresenter {
    
    weak var output : RegisterViewController?
    
    let passwordErrorMessages: [PasswordErrorType: String] = [
        PasswordErrorType.NoUpperCase:        "Password must contain at least 1 uppercase character",
        PasswordErrorType.NoLowerCase:        "Password must contain at least 1 lowercase character",
        PasswordErrorType.NoSpecialCharacter: "Password must contain at least 1 special character like $, &, ?, @, #, !",
        PasswordErrorType.NoSpecialCharacter: "Password must contain at least 1 digit",
        PasswordErrorType.LowSize:            "Password must be at least 8 characters"]
    
    func setUpErrorLabel(errorLabel: EntryLabels, isErrorPresent: Bool, _ errorType: PasswordErrorType? = nil) {
        switch(errorLabel) {
        case EntryLabels.Email : do {
            output?.activateError(errorLabel: (output?.lblEmailError)!, message: "Invalid email", isHidden: !isErrorPresent)
        }
        case EntryLabels.Password : do {
            output?.activateError(errorLabel: (output?.lblPasswordError)!, message: passwordErrorMessages[errorType!]!, isHidden: !isErrorPresent)
        }
        case EntryLabels.Name : do {
            output?.activateError(errorLabel: (output?.lblNameError)!, message: "Invalid Name", isHidden: !isErrorPresent)
        }
        case EntryLabels.ConfirmPassword : do {
            output?.activateError(errorLabel: (output?.lblConfirmPasswordError)!, message: "Password does not match.", isHidden: !isErrorPresent)
        }
        }
        output?.checkForValidForm()
    }
    
    func setUpAlertBox() {
        showAlertBox(alertBoxParameters: AlertBoxParamters(title: "Registration Failed", msg: "User already Exists", actions: [UIAlertAction(title: "Ok", style: .cancel)]), vc: output)
    }
    
    func nvaigateToLogin() {
        output?.router?.popToLogin()
    }
}
