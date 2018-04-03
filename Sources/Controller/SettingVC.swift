//
//  SettingVC.swift
//  LoginUI
//
//  Created by Apple  on 01/10/17.
//  Copyright © 2017 Apple . All rights reserved.
//

import UIKit

class SettingVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var backBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backBtnTapped () {
        self.dismiss(animated: false, completion: nil);
    }
}
