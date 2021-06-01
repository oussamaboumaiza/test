//
//  MarquePremiemViewController.swift
//  Test
//
//  Created by Oussama Boumaiza on 31/5/2021.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import AlamofireImage


class MarquePremiemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var ref:  DatabaseReference?
    var databaseHandle : DatabaseHandle?
    var data = [Brands]()
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Data : ",data.count)
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.layer.cornerRadius = 10

        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 10

        let image = cell.viewWithTag(1) as! UIImageView
        
        //print(data[indexPath.item].pic)
        if data[indexPath.item].pic != nil {
            image.af_setImage(withURL: URL(string: data[indexPath.item].pic!)!)

        }

       return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath) //appelle PrepareForSegue automatiquement
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   //     if segue.identifier == "toDetails"{
            let destination = segue.destination as! DetailsViewController
            let indice = sender as! IndexPath
            //destination.nomImage = id[indice.row] as! String
            destination.brand = data[indice.item]
            DispatchQueue.main.async(execute: {

                destination.modalPresentationStyle = .fullScreen  // This line is needed now

               // self.present(destination, animated: false)
            })
            //destination.nomImage = "1"
     //   }
    }
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set Delegates
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        title = "Marques Premium"
        // Register cells
      //  self.CollectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        self.CollectionView.layer.cornerRadius = 10
        
        fechData()

    }
    
    func fechData()  {
        ref =  Database.database().reference()
        ref?.child("brands").observeSingleEvent(of:.value) { snapshots in
            if  snapshots.exists() {
                guard let snapshot = snapshots.children.allObjects as? [DataSnapshot] else { return }
                print("snapshot: ",snapshot)
         for eachSnap in snapshot {
             guard let eachUserDict = eachSnap.value as? Dictionary<String,AnyObject> else { return }
          // eachUserDict is an object/ dictionary representation for each user
                  //let fullName = eachUserDict["fullName"] as? String
            
            if eachUserDict["premium"] as? Int == 1 {
                print("['advertiser']",eachUserDict["advertiser"] as? String)
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
                brands.isNew = eachUserDict["isNew"] as? Int


                self.data.append(brands)

            }
         

            }
                self.CollectionView.reloadData()

        }
        /*databaseHandle = ref?.child("brands").observe(.childAdded, with:{ snapshots in
           
        }*/
       
        
    }
     //   })
    }
}
