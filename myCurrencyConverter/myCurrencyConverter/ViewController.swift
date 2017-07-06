//
//  ViewController.swift
//  myCurrencyConverter
//
//  Created by chang on 2017/7/4.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var usdLbl: UILabel!
    @IBOutlet weak var cadLbl: UILabel!

    @IBOutlet weak var chfLbl: UILabel!
    
    @IBOutlet weak var jpyLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getCurrency(currency: searchBar.text!)
        searchBar.text = ""
    }
    
    func getCurrency(currency: String)
    {
        let url = URL(string: "http://api.fixer.io/latest?base=\(currency)")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "錯誤", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                if data != nil {
                    do {
                        //這行很重要
                        let JSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                        //async
                        DispatchQueue.main.async {
                            //print(JSONResult)
                            //讀取rates物件

                            let rates = JSONResult["rates"] as! [String: AnyObject]
                            
                            if let usd = rates["USD"]
                            {
                                self.usdLbl.text = "美金: \(usd)"
                            }
                            if let cad = rates["CAD"]
                            {
                                self.cadLbl.text = "加拿大幣: \(cad)"
                            }
                            if let chf = rates["CHF"]
                            {
                                self.chfLbl.text = "法郎: \(chf)"
                            }
                            if let jpy = rates["JPY"]
                            {
                                self.jpyLbl.text = "日幣: \(jpy)"
                            }
                            
                            
//                            let cad = String(describing: rates["CAD"]!)
//                            self.cadLbl.text = "加拿大幣: \(cad)"
//                            let chf = String(describing: rates["CHF"]!)
//                            self.chfLbl.text = "法郎: \(chf)"
//                            let jpy = String(describing: rates["JPY"]!)
//                            self.jpyLbl.text = "日幣: \(jpy)"
                            
                        }
                        
                    }catch{
                    
                    }
                   
                }
            }
            
        }
        //這行要加才會動
        task.resume()
    }

}

