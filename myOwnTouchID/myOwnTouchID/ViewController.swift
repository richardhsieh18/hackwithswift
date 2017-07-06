//
//  ViewController.swift
//  myOwnTouchID
//
//  Created by chang on 2017/7/4.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authContext = LAContext()
        var error: NSError?
        //用touchID解鎖
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            //彈出視窗
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "核對你的ID", reply: { (success, error) in
                if success {
                    self.resultLabel.text = "核對正確"
                }else{
                    self.resultLabel.text = "核對失敗"
                }
            })

        }
        
    }

    

}

