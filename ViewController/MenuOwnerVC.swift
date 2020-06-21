//
//  MenuOwnerVC.swift
//  GradutionThesis
//
//  Created by Buğra Tunçer on 5.04.2020.
//  Copyright © 2020 Buğra Tunçer. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class MenuOwnerVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var db : Firestore!
    var ownerCartArray = [OwnerCart]()
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        let menuItem = UIButton()
        menuItem.setImage(UIImage(named: "menu"), for: UIControl.State())
        menuItem.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        menuItem.addTarget(self, action: #selector(menuButtonClicked(_:)),for: .touchUpInside)
        
        let menuItem2 = UIBarButtonItem()
        menuItem2.customView = menuItem
        self.navigationItem.leftBarButtonItem = menuItem2
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getOrders()
        self.tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toMenu", sender: self)
    }
    
    @IBAction func addFoodClicked(_ sender: Any) {
        
    }
    func getOrders() {
        db.collection("Owner").document((Auth.auth().currentUser?.email!)!).collection("OwnerCart").addSnapshotListener { (snapshot, err) in
            if snapshot?.isEmpty != true && snapshot != nil {
                self.ownerCartArray.removeAll()
                for document in snapshot!.documents {
                    var item = OwnerCart()
                    if let foodName = document.get("Foodname") as? String {
                        item.foodName = foodName
                    }
                    if let plateNumber = document.get("Platenumber") as? String {
                        item.plateNumber = plateNumber
                    }
                    if let customerEmail = document.get("CustomerEmail") as? String {
                        item.customerEmail = customerEmail
                    }
                    if let imageURL = document.get("imageURl") as? String {
                        item.imageURL = imageURL
                    }
                    self.ownerCartArray.append(item)
                }
            }
        }
    }
    
}
extension MenuOwnerVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownerCartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = ownerCartArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OwnerTableViewCell {
            let url = URL(string: article.imageURL)!
            cell.imageVieww.sd_setImage(with: url)
            cell.nameFood.text = "Yemek ismi : \(article.foodName)"
            cell.plateCount.text = "Tabak sayisi : \(article.plateNumber)"
            cell.customerEmail.text = "Musteri email : \(article.customerEmail)"
            return cell
        }else {
            return UITableViewCell()
        }
        
    }
    
    
    
    
}
