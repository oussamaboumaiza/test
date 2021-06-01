//
//  ToutesLesMarquesViewController.swift
//  Test
//
//  Created by Oussama Boumaiza on 1/6/2021.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import AlamofireImage


class ToutesLesMarquesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        
        print(data[indexPath.item].pic)
        if data[indexPath.item].pic != nil {
            image.af_setImage(withURL: URL(string: data[indexPath.item].pic!)!)

        }

       return cell
    }
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set Delegates
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        title = "Toutes les marques"
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
         for eachSnap in snapshot {
             guard let eachUserDict = eachSnap.value as? Dictionary<String,AnyObject> else { return }
          // eachUserDict is an object/ dictionary representation for each user
                  //let fullName = eachUserDict["fullName"] as? String
          
                let brands = Brands()
                brands.offerId = eachUserDict["offerId"] as? Int
                brands.pic = eachUserDict["pic"] as? String
                brands.name = eachUserDict["name"] as? String
                brands.desc = eachUserDict["description"] as? String
                brands.premium = eachUserDict["premium"] as? Int
                brands.isNew = eachUserDict["isNew"] as? Int


                self.data.append(brands)
                print(eachUserDict)

            
         

            }
                self.CollectionView.reloadData()

        }
        /*databaseHandle = ref?.child("brands").observe(.childAdded, with:{ snapshots in
           
        }*/
       
        
    }
     //   })
    }
}
