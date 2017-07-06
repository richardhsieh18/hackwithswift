//
//  FirstViewController.swift
//  myUdTravelMapBook
//
//  Created by chang on 2017/7/4.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArr = [String]()
    var subtitleArr = [String]()
    var latitudeArr = [Double]()
    var longitudeArr = [Double]()
    
    var chosenTitle = ""
    var chosenSubtitle = ""
    var chosenLatitude : Double = 0
    var chosenLongitude : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //原本沒看到資料，忘記加了
        fetchData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name(rawValue: "新位置已儲存"), object: nil)
    }
    //fetch core Data
    func fetchData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                self.titleArr.removeAll(keepingCapacity: false)
                self.subtitleArr.removeAll(keepingCapacity: false)
                self.latitudeArr.removeAll(keepingCapacity: false)
                self.longitudeArr.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject]{
                    if let title = result.value(forKey: "title") as? String
                    {
                        self.titleArr.append(title)
                    }
                    if let subtitle = result.value(forKey: "subtitle") as? String{
                        self.subtitleArr.append(subtitle)
                    }
                    if let latitude = result.value(forKey: "latitude") as? Double{
                        self.latitudeArr.append(latitude)
                    }
                    if let longitude = result.value(forKey: "longitude") as? Double {
                        self.longitudeArr.append(longitude)
                    }
                    //第一輪忘了打
                    self.tableView.reloadData()
                }
            }
        }catch{
            print("Error")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle = titleArr[indexPath.row]
        chosenSubtitle = subtitleArr[indexPath.row]
        chosenLatitude = latitudeArr[indexPath.row]
        chosenLongitude = longitudeArr[indexPath.row]
        
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArr[indexPath.row]
        print(titleArr[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC"{
            let destinationVC = segue.destination as! ViewController
            destinationVC.transmittedTitle = chosenTitle
            destinationVC.transmittedSubtitle = chosenSubtitle
            destinationVC.transmittedLatitude = chosenLatitude
            destinationVC.transmittedLongitude = chosenLongitude
        }
    }

    @IBAction func addBtnClicked(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }

}
