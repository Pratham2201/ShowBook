//
//  RegisterViewModel.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 20/04/23.
//

import Foundation

enum EntryLabels {
    case Name, Email, Password, ConfirmPassword
}

enum PasswordErrorType {
    case NoDigit, NoUpperCase, NoLowerCase, NoSpecialCharacter, LowSize, NoError
}

//AlertBoxParameter : From LoginViewModel
