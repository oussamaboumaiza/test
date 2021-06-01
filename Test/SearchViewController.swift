//
//  SearchViewController.swift
//  Test
//
//  Created by Oussama Boumaiza on 1/6/2021.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
class ResultsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
    }
}
class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var CollectionView: UICollectionView!
    var ref:  DatabaseReference?
    var databaseHandle : DatabaseHandle?
    var data = [Brands]()
    var result = [Brands]()

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(result.count)
        return result.count
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
            if result[indexPath.item].pic != nil {
                image.af_setImage(withURL: URL(string: result[indexPath.item].pic!)!)

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
        print(indice.item)
            destination.brand = result[indice.item]
            DispatchQueue.main.async(execute: {

                destination.modalPresentationStyle = .fullScreen  // This line is needed now

               // self.present(destination, animated: false)
            })
            //destination.nomImage = "1"
     //   }
    }
  

    
    
    let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recherche"
        fechData()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater =  self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar .text else {
            return
        }
        let vc = searchController.searchResultsController as? ResultsVC
        
        print(text)
        if !text.isEmpty {
            result.removeAll()
            self.CollectionView.reloadData()

            for brand in data {
                print(brand.name!," - ",brand.name!.lowercased().range(of:text.lowercased()) != nil," - ",text.lowercased())
                if (brand.name!.lowercased().range(of:text.lowercased()) != nil ) {
                    
                   result.append(brand)
                    self.CollectionView.reloadData()
                }
            }
        }
        
    }
    
    func fechData()  {
        ref =  Database.database().reference()
        ref?.child("brands").observeSingleEvent(of:.value) { snapshots in
            if  snapshots.exists() {
                guard let snapshot = snapshots.children.allObjects as? [DataSnapshot] else { return }
         for eachSnap in snapshot {
             guard let eachUserDict = eachSnap.value as? Dictionary<String,AnyObject> else { return }
          
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
              //  self.CollectionView.reloadData()

        }
        
    }
    }
}
