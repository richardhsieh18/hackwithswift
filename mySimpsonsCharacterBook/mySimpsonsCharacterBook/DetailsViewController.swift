//
//  DetailsViewController.swift
//  mySimpsonsCharacterBook
//
//  Created by chang on 2017/7/2.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    
    var selectedSimpon = Simpson()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedSimpon.name
        occupationLabel.text = selectedSimpon.occupation
        imageView.image = selectedSimpon.image
        
        
    }


}
