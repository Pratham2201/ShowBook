//
//  LoginViewController.swift
//  Movie Booking App
//
//  Created by Pratham Gupta on 04/04/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmailID: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnRegisterUser: UIButton!
    
    var router: ILoginRouter!
    var output: ILoginInteractor!
    
    let borderEmail = CALayer()
    let borderPassword = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBorder(border: borderEmail, textField: tfEmailID)
        setUpBorder(border: borderPassword, textField: tfPassword)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        LoginConfigurator.configure(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LoginConfigurator.configure(viewController: self)
    }
    
    @IBAction func onCLickRegisterUser(_ sender: Any) {
        router.routeToRegisterScreen()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        output.validateUser(userEmail: tfEmailID.text!, userPassword: tfPassword.text!)
    }
    
}

extension LoginViewController {
    func setUpBorder(border: CALayer, textField: UITextField) {
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.height + 12, width: textField.frame.width, height: 1)
        textField.layer.addSublayer(border)
        self.view.layer.masksToBounds = true
    }
}
