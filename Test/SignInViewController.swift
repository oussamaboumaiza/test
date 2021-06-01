//
//  SignInViewController.swift
//  Test
//
//  Created by Oussama Boumaiza on 30/5/2021.
//

import UIKit
import FirebaseAuth
class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInBtn: UIView!
    @IBOutlet weak var username: UIView!
    @IBOutlet weak var emailFied: UITextField!
    @IBOutlet weak var password: UIView!
    @IBOutlet weak var passwordFied: UITextField!
    @IBOutlet weak var fPassword: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.layer.cornerRadius = 10
        password.layer.cornerRadius = 10
        signInBtn.layer.cornerRadius = 10
        hideKeyboardWhenTappedAround()

    }
    @IBAction func SingIn(_ sender: Any) {
  
        guard let email = emailFied.text, !email.isEmpty, let password = passwordFied.text, !password.isEmpty else {
            print("Missing fieds data")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self]result,error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else{
                strongSelf.showCreateAccount(email: email ,password: password)
            return
        }
        print("You have signed in")
            ViewController.setView(viewController: self!, Identifier: "TabBarController")
        
        })
      
        //ViewController.setView(viewController: self, Identifier: "SpaceChoseViewController")

    }
    func showCreateAccount(email :  String, password : String) {
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            DispatchQueue.main.async(execute: {

                controller.modalPresentationStyle = .fullScreen  // This line is needed now
              controller.emailSet = email

                self.present(controller, animated: false)
            })
                //53199617

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
        
        present(alert, animated: true)
    }
    
 
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

