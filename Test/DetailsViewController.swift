//
//  DetailsViewController.swift
//  Test
//
//  Created by Oussama Boumaiza on 1/6/2021.
//

import UIKit
import AlamofireImage
import FirebaseCore
import FirebaseDatabase

class DetailsViewController: UIViewController {
    var ref:  DatabaseReference?
    var databaseHandle : DatabaseHandle?
    var brand = Brands()
    var amountTot:Double = 0.0
    var comTot:Double = 0.0
    var totVent:Int = 0

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var ca: UILabel!
    @IBOutlet weak var commision: UILabel!
    @IBOutlet weak var totVente: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(brand.name!+" - "+brand.offerId!+" - "+brand.desc!)
        DispatchQueue.main.async(execute: {
            self.fechData()
        })
        name.text = String(brand.name!)
        desc.text = brand.desc
        image.layer.cornerRadius = 10
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        view3.layer.cornerRadius = 10
        image.af_setImage(withURL: URL(string: brand.pic!)!)
      
    }
    func fechData()  {
        ref =  Database.database().reference()
        ref?.child("conversions").child("purchase").observeSingleEvent(of:.value) { snapshots in
            if  snapshots.exists() {
                guard let snapshot = snapshots.children.allObjects as? [DataSnapshot] else { return }
               // print("snapshot: ",snapshot)
       for eachSnap in snapshot {
             guard let eachUserDict = eachSnap.value as? Dictionary<String,AnyObject> else { return }
          // eachUserDict is an object/ dictionary representation for each user
                  //let fullName = eachUserDict["fullName"] as? String
            print("eachUserDict: ",eachUserDict)
            print("['offerId'] ",eachUserDict["offerId"] as? Int)

            print("['commission'] ",eachUserDict["commission"] as? String)
            if eachUserDict["offerId"] as? Int == self.brand.offerId {
                self.amountTot += (eachUserDict["amount"] as? Double)!
                if (eachUserDict["commission"] != nil) {
                    self.comTot += Double((eachUserDict["commission"] as? String)!)!
                }
                self.totVent += 1
                /* print("['advertiser']",eachUserDict["advertiser"] as? String)
                 print("['commissions-en']",eachUserDict["commissions-en"] as? String)
                 print("['description-en']",eachUserDict["description-en"] as? String)
                 print("['offerId']",eachUserDict["offerId"] as? Int)
                 print("['name']",eachUserDict["name"] as? String)
                 print("['categories-en']",eachUserDict["categories-en"] as? String)
                 print("['description']",eachUserDict["description"] as? String)
                 print("['displayName']",eachUserDict["displayName"] as? String)
                 print("['href']",eachUserDict["href"] as? String)
                 print("['catégorie']",eachUserDict["catégorie"] as? String)
                 print("['premium']",eachUserDict["premium"] as? Int)
                 print("['pic']",eachUserDict["pic"] as? String)
                 print("['picPremium']",eachUserDict["picPremium"] as? String)
                 print("['commissions']",eachUserDict["commissions"] as? String)
                 print("['private']",eachUserDict["private"] as? Int)
                 print("['isNew']",eachUserDict["private"] as? Int)

 print("------------------------------------------------------------")
                 print("eachUserDict",eachUserDict)

                 let brands = Brands()
                 brands.offerId = eachUserDict["offerId"] as? Int
                 brands.pic = eachUserDict["pic"] as? String
                 brands.name = eachUserDict["name"] as? String
                 brands.desc = eachUserDict["description"] as? String
                 brands.premium = eachUserDict["premium"] as? Int
                 brands.isNew = eachUserDict["isNew"] as? Int*/

            }

            }
                self.ca.text = String(Double(round(1000*self.amountTot)/1000))+"€"
                self.commision.text = String(Double(round(1000*self.comTot)/1000))+"€"
                self.totVente.text = String(self.totVent)

            }
        }
    }
}
