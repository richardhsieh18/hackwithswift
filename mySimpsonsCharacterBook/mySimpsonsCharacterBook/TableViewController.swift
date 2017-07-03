//
//  ViewController.swift
//  mySimpsonsCharacterBook
//
//  Created by chang on 2017/7/2.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var mySimpsons = [Simpson]()
    var chosenSimpson = Simpson()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableview Setup
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //辛普森家族
        let homer = Simpson()
        homer.name = "Homer Simpson"
        homer.occupation = "Safety Inspector"
        homer.image = UIImage(named: "homer.png")!
        
        let bart = Simpson()
        bart.name = "Bart Simpson"
        bart.occupation = "Student"
        bart.image = UIImage(named: "bart.png")!
        
        let lisa = Simpson()
        lisa.name = "Lisa"
        lisa.occupation = "Homermaker"
        lisa.image = UIImage(named: "lisa.png")!
        
        mySimpsons.append(homer)
        mySimpsons.append(bart)
        mySimpsons.append(lisa)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = mySimpsons[indexPath.row].name
        
        return cell
    }
    //引用型別
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVc"{
            let VC2 = segue.destination as! DetailsViewController
            VC2.selectedSimpon = self.chosenSimpson
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chosenSimpson = mySimpsons[indexPath.row]
        performSegue(withIdentifier: "toDetailVc", sender: nil)
    }



}

