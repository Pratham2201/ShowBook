//
//  RegisterInteractor.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation

protocol IRegisterInteractor {
    
    func checkName(name: String?)
    
    func checkEmail( userEmail: String?)
    
    func checkPassword(userPassword:String?)
    
    func checkConfirmPassword(userPassword:String?, userConfirmPassword: String?)
    
    func invalidEmail(_ value: String) -> Bool
    
    func matchPasswords(_ value: String, password: String)-> Bool
    
    func invalidPassword(_ value: String) -> PasswordErrorType
    
    func containsDigit(_ value: String) -> Bool
    
    func containsSpecialCharacter(_ value: String) -> Bool
    
    func containsUpperCase(_ value: String) -> Bool
    
    func checkRegisteredUsers(registerUser: User)
}

class RegisterInteractor: IRegisterInteractor {
    
    var output: IRegisterPresenter?
    
    func checkRegisteredUsers(registerUser: User) {
        for user in users {
            if(user.email == registerUser.email) {
                output?.setUpAlertBox()
                return
            }
        }
        users.append(registerUser)
        output?.nvaigateToLogin()
    }
    
    func checkName(name: String?) {
        if name != ""{
            output?.setUpErrorLabel(errorLabel: EntryLabels.Name, isErrorPresent: false, nil)
        } else{
            output?.setUpErrorLabel(errorLabel: EntryLabels.Name, isErrorPresent: true, nil)
        }
    }
    
    func checkEmail(userEmail: String?) {
        if let email = userEmail {
            if invalidEmail(email) {
                output?.setUpErrorLabel(errorLabel: EntryLabels.Email, isErrorPresent: true, nil)
            } else {
                output?.setUpErrorLabel(errorLabel: EntryLabels.Email, isErrorPresent: false, nil)
            }
        }
    }
    
    func checkPassword(userPassword:String?) {
        if let password = userPassword {
            let errorType = invalidPassword(password)
            output?.setUpErrorLabel(errorLabel: EntryLabels.Email, isErrorPresent: true, errorType)
        }
    }
    
    func checkConfirmPassword(userPassword:String?, userConfirmPassword: String?) {
        if let confirmPassword = userConfirmPassword, let password = userPassword {
            if(matchPasswords(confirmPassword, password: password)) {
                output?.setUpErrorLabel(errorLabel: EntryLabels.Email, isErrorPresent: true, nil)
            } else {
                output?.setUpErrorLabel(errorLabel: EntryLabels.Email, isErrorPresent: true, nil)
            }
        }
    }
    
    func invalidEmail(_ value: String) -> Bool {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value){
            return true
        } else {
            return false
        }
    }
    
    func matchPasswords(_ value: String, password: String)-> Bool{
        if(value != password){
            return true
        } else {
            return false
        }
    }
    
    func invalidPassword(_ value: String) -> PasswordErrorType {
        if containsUpperCase(value) {
            return PasswordErrorType.NoUpperCase
        }
        if containsLowerCase(value) {
            return PasswordErrorType.NoLowerCase
        }
        if containsSpecialCharacter(value) {
            return PasswordErrorType.NoSpecialCharacter
        }
        if containsDigit(value) {
            return PasswordErrorType.NoDigit
        }
        if value.count < 8 {
            return PasswordErrorType.LowSize
        }
        return PasswordErrorType.NoError
    }
    
    func containsDigit(_ value: String) -> Bool {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsSpecialCharacter(_ value: String) -> Bool {
        let reqularExpression = ".*[$&?@#!]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
}
