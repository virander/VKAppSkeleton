//
//  LoginVC.swift
//  LoginUI
//
//  Created by Apple  on 26/09/17.
//  Copyright © 2017 Apple . All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView : UIScrollView!;
    @IBOutlet var userNameTF : UITextField!;
    @IBOutlet var passwordTF : UITextField!;
    @IBOutlet var loginBtn : UIButton!;
    @IBOutlet var forgetPasswordBtn : UIButton!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.clear;
        scrollView.bounces = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.isPagingEnabled = true;
        scrollView.delegate = self;
    }

    @IBAction func moveToTabBarVC () {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainContainerVC") as! MainContainerVC;
        self.show(mainVC, sender: self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


