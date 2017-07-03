//
//  ImageViewController.swift
//  myLandmarkImageBook
//
//  Created by chang on 2017/7/2.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var imageT: UIImageView!
    
    var selectedLandmarkName = "name"
    var selectedLandmarkImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = selectedLandmarkName
        imageT.image = selectedLandmarkImage
        



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
