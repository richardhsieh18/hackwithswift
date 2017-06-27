//
//  DetailViewController.swift
//  hw1StormViewer
//
//  Created by chang on 2017/6/15.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func shareTapped() {
         //使用內建功能
//        let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(vc, animated: true)
        //使用facebook發文
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
            vc.setInitialText("媽我在這發文了")
            vc.add(imageView.image!)
            //vc.add(URL(string: "http://www.photolib.noaa.gov/nssl"))
            present(vc, animated: true)
        }
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
