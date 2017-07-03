//
//  ViewController.swift
//  myLandmarkImageBook
//
//  Created by chang on 2017/7/2.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    //建兩個Array
    var landmarkNamesArr = [String]()
    var landmarkImageArr = [UIImage]()
    
    var chooseLandmarkName = ""
    var chooseLandmarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        landmarkNamesArr.append("Taji")
        landmarkNamesArr.append("London")
        landmarkNamesArr.append("Opera")
        
        landmarkImageArr.append(UIImage(named: "taji.jpg")!)
        landmarkImageArr.append(UIImage(named: "london.jpg")!)
        landmarkImageArr.append(UIImage(named: "opera.jpg")!)
    }

    //tableview的兩個delegate方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNamesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //將text改成陣列裡的[indexPath.row]
        cell.textLabel?.text = landmarkNamesArr[indexPath.row]
        
        return cell
    }
    
    //增加刪除列功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            landmarkNamesArr.remove(at: indexPath.row)
            landmarkImageArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageSegue" {
            let destinationVC = segue.destination as! ImageViewController
            destinationVC.selectedLandmarkName = chooseLandmarkName
            destinationVC.selectedLandmarkImage = chooseLandmarkImage
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chooseLandmarkName = landmarkNamesArr[indexPath.row]
        self.chooseLandmarkImage = landmarkImageArr[indexPath.row]
        performSegue(withIdentifier: "toImageSegue", sender: nil)
        
    }
    



}

