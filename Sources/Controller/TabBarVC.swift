//
//  TabBarVC.swift
//  LoginUI
//
//  Created by Apple  on 26/09/17.
//  Copyright © 2017 Apple . All rights reserved.
//

import Foundation
import UIKit
protocol TabBarDelegate
{
    func detectScrolling (isScrollUp : Bool) -> Void
    func addViewToMainView () -> Void
}

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    var customDelegate : TabBarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
