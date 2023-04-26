//
//  ViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 04/04/23.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblConfirmPasswordError: UILabel!
    
    let borderName = CALayer()
    let borderEmail = CALayer()
    let borderPassword = CALayer()
    let borderConfirmPassword = CALayer()
    
    var output: IRegisterInteractor?
    var router: IRegisterRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBorder(border: borderName, textField: tfName)
        setUpBorder(border: borderEmail, textField: tfEmail)
        setUpBorder(border: borderPassword, textField: tfPassword)
        setUpBorder(border: borderConfirmPassword, textField: tfConfirmPassword)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        RegisterConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        RegisterConfigurator.configure(viewController: self)
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        output?.checkEmail(userEmail: tfEmail.text)
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        output?.checkName(name: tfName.text)
    }
    
    @IBAction func confirmPasswordChanged(_ sender: Any) {
        output?.checkConfirmPassword(userPassword: tfPassword.text, userConfirmPassword: tfConfirmPassword.text)
    }
    
    @IBAction func btnRegisterTapped(_ sender: Any) {
        registerAndNaviagte()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        router?.popToLogin()
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        output?.checkPassword(userPassword: tfPassword.text)
    }
    
    func registerAndNaviagte(){
        output?.checkRegisteredUsers(registerUser: User(name: tfName.text!, email: tfEmail.text!, password: tfPassword.text!))
    }
}

extension RegisterViewController {
    func setUpBorder(border: CALayer, textField: UITextField) {
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.height + 12, width: textField.frame.width, height: 1)
        textField.layer.addSublayer(border)
        self.view.layer.masksToBounds = true
    }
    
    func activateError(errorLabel: UILabel, message: String, isHidden: Bool) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func checkForValidForm() {
        if lblPasswordError.isHidden && lblEmailError.isHidden && lblNameError.isHidden && lblConfirmPasswordError.isHidden {
            btnCreateAccount.isEnabled = true
            btnCreateAccount.tintColor = .link
        } else {
            btnCreateAccount.isEnabled = false
            btnCreateAccount.tintColor = .gray
        }
    }
}

