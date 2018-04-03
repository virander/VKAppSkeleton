//
//  MainContainerVC.swift
//  LoginUI
//
//  Created by Apple  on 26/09/17.
//  Copyright © 2017 Apple . All rights reserved.
//

import UIKit

class MainContainerVC: UIViewController, UIGestureRecognizerDelegate, TabBarDelegate {

    @IBOutlet var settingBtn : UIButton?;
    @IBOutlet var headerView : UIView?
    var panGesture  = UIPanGestureRecognizer()
    var tabBarVC : TabBarVC?;
    var tabBarView : UIView?;
    
    var settingVC : SettingVC?;
    var settingView : UIView?;
    
    var activityIndicator       : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Set activity view indicator
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator?.color = UIColor.green
        activityIndicator?.center = view.center
        self.view.addSubview(activityIndicator!)
        self.intitializedMainContainer();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func intitializedMainContainer() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
        
        let yCord : CGFloat! = (self.headerView?.frame.origin.y)! + (self.headerView?.bounds.height)!
        
        /*add tab bar as child view controller*/
        tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC?
        tabBarVC?.view.frame = CGRect(x:0, y:yCord, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - yCord)
        tabBarVC?.customDelegate = self
        tabBarView = tabBarVC?.view
        self.addChildViewController(tabBarVC!)
        self.view.addSubview(tabBarView!)
        
        /*add setting View as child view controller*/
        settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC?
        settingVC?.view.frame = CGRect(x:-UIScreen.main.bounds.width, y:0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //settingVC?.customDelegate = self
        settingView = settingVC?.view
        self.addChildViewController(settingVC!)
        self.view.addSubview(settingView!)
    }
    
    @IBAction func settingBtnTapped () {
        self.tapOnTransparentView(false);
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubview(toFront: settingView!)
        let velocity : CGPoint = sender.velocity(in: sender.view)
        if velocity.x > 0 {
            self.tapOnTransparentView(false);
        } else {
            self.tapOnTransparentView(true);
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func tapOnTransparentView (_ isHidden : Bool) -> Void {
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.2,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.4,
                       options: .curveLinear,
                       animations: {
                        if isHidden {
                            self.settingView!.frame.origin.x = -UIScreen.main.bounds.width;
                        }
                        else {
                            self.settingView!.frame.origin.x = 0;
                        }
                        
        }, completion: {
            complete -> Void in
        })
    }
    
    func detectScrolling(isScrollUp: Bool) {
        
    }
    
    func addViewToMainView() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
