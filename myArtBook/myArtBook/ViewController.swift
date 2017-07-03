//
//  ViewController.swift
//  myArtBook
//
//  Created by chang on 2017/7/2.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var nameArr = [String]()
    var yearArr = [Int]()
    var artistArr = [String]()
    var imageArr = [UIImage]()
    
    var selectedPatinting = ""

    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        retrieveInfo()
        
    }
    
    //Notifaction  L88
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(retrieveInfo), name: NSNotification.Name(rawValue: "圖片已儲存"), object: nil)
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        //Error Handling
        self.selectedPatinting = ""
        self.performSegue(withIdentifier: "toCreateVC", sender: nil)
        
    }
    //Set TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPatinting = nameArr[indexPath.row]
        performSegue(withIdentifier: "toCreateVC", sender: nil)
    }
    
    //自己增加刪除方法，但沒有刪掉CoreData中的資料
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            nameArr.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateVC"{
            let destinationVC = segue.destination as! CreateVC
            destinationVC.chosenPainting = selectedPatinting
        }
    }
    //Get coreData
    func retrieveInfo(){
        //接受資料之前先清除陣列
        self.nameArr.removeAll(keepingCapacity: false)
        self.yearArr.removeAll(keepingCapacity: false)
        self.artistArr.removeAll(keepingCapacity: false)
        self.imageArr.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do{
            
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as? String{
                        self.nameArr.append(name)
                    }
                    if let year = result.value(forKey: "year") as? Int{
                        self.yearArr.append(year)
                    }
                    if let artist = result.value(forKey: "artist") as? String{
                        self.artistArr.append(artist)
                    }
                    
                    if let ImageData = result.value(forKey: "image") as? Data{
                        let image = UIImage(data: ImageData)
                        self.imageArr.append(image!)
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }catch{
        }
    }
}

