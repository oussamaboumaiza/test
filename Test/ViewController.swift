//
//  ViewController.swift
//  Test
//
//  Created by Oussama Boumaiza on 30/5/2021.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var signEmail: UIView!

    @IBOutlet weak var signUpbtn: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signEmail.layer.cornerRadius = 10

        /*Database
            .database()
            .reference()
            .child("brands")
            .queryOrderedByKey()
            .observeSingleEvent(of: .value, with: { snapshot in

                guard let dict = snapshot.value as? [String:Any] else {
                    print("Error")
                    return
                }
               // print(dict["advertiser"] as! String )
            })*/
    
    }

    @IBAction func toSignInEmail(_ sender: Any) {
        ViewController.setView(viewController: self, Identifier: "SignInViewController")
    }
    
    @IBAction func toSignUp(_ sender: Any) {
        ViewController.setView(viewController: self, Identifier: "SignUpViewController")
    }
    
    static  func setView(viewController : UIViewController, Identifier : String){
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let controller = storyboard.instantiateViewController(withIdentifier: Identifier) as! UIViewController
          DispatchQueue.main.async(execute: {

              controller.modalPresentationStyle = .fullScreen  // This line is needed now

              viewController.present(controller, animated: false)
          })
      }

}

