//
//  StartupVC.swift
//  LoginUI
//
//  Created by Apple  on 04/10/17.
//  Copyright © 2017 Apple . All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StartupVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView : UIScrollView!;
    @IBOutlet var pagerController : UIPageControl?;
    @IBOutlet var signInBtn : UIButton?;
    @IBOutlet var signUpBtn : UIButton?;
    var userImg : UIImageView?;
    var videoPlayerLayer : AVPlayerLayer!;
    var videoPlayer : AVPlayer!;
    var view1 : UIView? = UIView.init();
    var view2 : UIView? = UIView.init();
    var view3 : UIView? = UIView.init();
    var view4 : UIView? = UIView.init();
    var label : UILabel!;
    var deviceWidth : CGFloat? = 0.0;
    var deviceHeight : CGFloat? = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.borderWidth = 1.0;
        self.view.layer.borderColor = UIColor.darkGray.cgColor;
        self.view.backgroundColor = UIColor.gray;
        
        scrollView.backgroundColor = UIColor.white;
        scrollView.bounces = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.isPagingEnabled = true;
        scrollView.delegate = self;
        
        pagerController?.isUserInteractionEnabled = false;
        
        self.signInBtn?.layer.borderWidth = 1.0;
        self.signInBtn?.layer.cornerRadius = 4.0;
        self.signInBtn?.layer.borderColor = UIColor.white.cgColor;
        self.signInBtn?.backgroundColor = UIColor.blue;
        self.signInBtn?.setTitleColor(UIColor.white, for: .normal);
        self.signInBtn?.setTitle("Sign In", for: .normal);
        
        self.signUpBtn?.layer.borderWidth = 1.0;
        self.signUpBtn?.layer.cornerRadius = 4.0;
        self.signUpBtn?.backgroundColor = UIColor.blue;
        self.signUpBtn?.layer.borderColor = UIColor.white.cgColor;
        self.signUpBtn?.setTitleColor(UIColor.white, for: .normal);
        self.signUpBtn?.setTitle("Sign Up", for: .normal);
        
        deviceWidth = UIScreen.main.bounds.size.width;
        deviceHeight = UIScreen.main.bounds.size.height;
        
        self.view1 = UIView.init(frame: CGRect(x:0, y:0, width: deviceWidth!, height: deviceHeight!));
        self.view1?.backgroundColor = UIColor.clear;
        //self.view1?.applyGradient(colours: [UIColor(hex: "D1FFFF"), UIColor(hex: "00FFFF")]);
        scrollView.addSubview(self.view1!);
        self.initializeVideoPlayer();
        
        self.view2 = UIView.init(frame: CGRect(x:deviceWidth!, y:0, width: deviceWidth!, height: deviceHeight!));
        self.view2?.applyGradient(colours: [UIColor(hex: "00FFC3"), UIColor(hex: "00FF09")]);
        scrollView.addSubview(self.view2!);
        
        self.view3 = UIView.init(frame: CGRect(x:2*deviceWidth!, y:0, width: deviceWidth!, height: deviceHeight!));
        self.view3?.applyGradient(colours: [UIColor(hex: "595BA3"), UIColor(hex: "595BFF")]);
        scrollView.addSubview(self.view3!);
        
        self.view4 = UIView.init(frame: CGRect(x:3*deviceWidth!, y:0, width: deviceWidth!, height: deviceHeight!));
        self.view4?.applyGradient(colours: [UIColor(hex: "5990FF"), UIColor(hex: "009DFF")]);
        scrollView.addSubview(self.view4!);
        
        self.userImg = UIImageView.init(frame: CGRect(x:deviceWidth! / 3 + deviceWidth!, y:deviceHeight! / 6, width: deviceWidth! / 3, height: deviceWidth! / 3));
        self.userImg?.backgroundColor = UIColor.purple;
        self.userImg?.layer.cornerRadius = (self.userImg?.bounds.height)! / 2;
        self.userImg?.layer.masksToBounds = true;
        self.view.addSubview(self.userImg!);
        
        scrollView.contentSize = CGSize(width:4*deviceWidth!, height: deviceHeight!);
        
    }
    
    func initializeVideoPlayer() {
        
        let item : AVPlayerItem? = AVPlayerItem.init(url: Bundle.main.url(forResource: "splashVideo_iPhone", withExtension: "mp4")!);
        videoPlayer = AVPlayer.init(playerItem: item!);
        videoPlayer.allowsExternalPlayback = true;
        videoPlayer.play()
        
        videoPlayerLayer = AVPlayerLayer.init(player: videoPlayer);
        videoPlayerLayer.frame = self.view.bounds;
        self.view1?.layer.insertSublayer(videoPlayerLayer, at: 0);
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem)
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        videoPlayer.seek(to: kCMTimeZero);
        videoPlayer.play()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = self.scrollView?.contentOffset.x;
        let w = self.scrollView?.bounds.size.width;
        let currentPage = x!/w!;
        var scrollFactor : CGFloat? = 0.0;
        var sizeFactor : CGFloat? = 0.0
        
        switch Int(currentPage) {
        case 0:
            scrollFactor = deviceWidth! / 3 + deviceWidth! - x!;
            sizeFactor = deviceWidth! / 3;
            break;
            
        case 1:
            scrollFactor = deviceWidth! / 3 + 13 * (deviceWidth! - x!) / 48;
            sizeFactor = deviceWidth! / 9 + 2 * (2*deviceWidth! - x!) / 9;
            break;
            
        case 2:
            scrollFactor = deviceWidth! / 16 + 3 * (x! - 2 * deviceWidth!) / 80;
            sizeFactor = deviceWidth! / 6 + (x! - 3*deviceWidth!) / 18;
            break;
            
        case 3:
            scrollFactor = deviceWidth! / 10;
            sizeFactor = deviceWidth! / 6;
            break;
            
        default:
            break;
        }
        self.userImg?.frame.origin.x = scrollFactor!
        self.userImg?.frame.size.width = sizeFactor!;
        self.userImg?.frame.size.height = sizeFactor!;
        self.userImg?.layer.cornerRadius = (self.userImg?.bounds.height)! / 2;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = self.scrollView?.contentOffset.x;
        let w = self.scrollView?.bounds.size.width;
        let currentPage = Int(ceil(x!/w!));
        pagerController?.currentPage = (currentPage);
        
        if currentPage == 0 {
            self.signInBtn?.layer.borderColor = UIColor.white.cgColor;
            self.signInBtn?.backgroundColor = UIColor.blue;
            self.signInBtn?.setTitleColor(UIColor.white, for: .normal);
            
            self.signUpBtn?.layer.borderColor = UIColor.white.cgColor;
            self.signUpBtn?.backgroundColor = UIColor.blue;
            self.signUpBtn?.setTitleColor(UIColor.white, for: .normal);
        }
        else {
            self.signInBtn?.layer.borderColor = UIColor.blue.cgColor;
            self.signInBtn?.backgroundColor = UIColor.white;
            self.signInBtn?.setTitleColor(UIColor.blue, for: .normal);
            
            self.signUpBtn?.layer.borderColor = UIColor.blue.cgColor;
            self.signUpBtn?.backgroundColor = UIColor.white;
            self.signUpBtn?.setTitleColor(UIColor.blue, for: .normal);
        }
    }
    
    @IBAction func moveToLogin () {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC;
        self.show(mainVC, sender: self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

