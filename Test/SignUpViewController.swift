//
//  SignUpViewController.swift
//  Test
//
//  Created by Oussama Boumaiza on 30/5/2021.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UIView!
    @IBOutlet weak var password: UIView!
    @IBOutlet weak var cPassword: UIView!
    @IBOutlet weak var signupBtn: UIView!
    @IBOutlet weak var emailFied: UITextField!
    @IBOutlet weak var passwordFied: UITextField!
    @IBOutlet weak var cPasswordFied: UITextField!

    var emailSet : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        email.layer.cornerRadius = 10
        password.layer.cornerRadius = 10
        cPassword.layer.cornerRadius = 10
        signupBtn.layer.cornerRadius = 10
        if emailSet != nil {
            emailFied.text = emailSet

        }


        hideKeyboardWhenTappedAround()

    }
    
    @IBAction func SignUp(_ sender: Any) {
        guard let email = emailFied.text, !email.isEmpty, let password = passwordFied.text, !password.isEmpty, let cPassword = cPasswordFied.text, !cPassword.isEmpty else {
            print("Missing fieds data")
            return
        }
        if password == cPassword {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion:{[weak self]result,error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else{
                    print("Account creation failed")
                return
            }
            print("You have signed in")
                ViewController.setView(viewController: self!, Identifier: "TabBarController")

            })
        }
        
       
        //ViewController.setView(viewController: self, Identifier: "SpaceChoseViewController")
    }
}

