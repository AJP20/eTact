//
//  ViewController.swift
//  TestContact
//
//  Created by Andrew Phillips on 8/27/17.
//  Copyright © 2017 Andrew Phillips. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var settingsImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        name.text = "Andrew Phillips"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageTapped(gesture:)))
        
        // add it to the image view;
        settingsImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        settingsImage.isUserInteractionEnabled = true
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Here you can initiate your new ViewController
            performSegue(withIdentifier: "EditProfileSegue", sender: nil)
        }
    }
    
    @IBAction func snapchatButton(_ sender: UIButton) {
        let snapchatExtention = "snapchat://add/ajp_20"
        let snapchatUrl = URL(string: snapchatExtention)
        if UIApplication.shared.canOpenURL(snapchatUrl! as URL)
        {
            UIApplication.shared.open(snapchatUrl!)
            
        } else {
            //opens current app in the app store if URL can't open
            UIApplication.shared.open(URL(string: "https://itunes.apple.com/in/app/snapchat/id447188370?mt=8")!)
        }
    }
    
    @IBAction func instagramButton(_ sender: UIButton) {
        let instagramExtention = "instagram://user?username=ajp20"
        let instagramUrl = URL(string: instagramExtention)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.open(instagramUrl!)
            
        } else {
            //opens current app in the app store if URL can't open
            UIApplication.shared.open(URL(string: "https://itunes.apple.com/in/app/instagram/id389801252?m")!)
        }
    }
    
    @IBAction func twitterButton(_ sender: UIButton) {
        let twitterExtention = "twitter://user?screen_name=ajp_20"
        let twitterUrl = URL(string: twitterExtention)
        if UIApplication.shared.canOpenURL(twitterUrl! as URL)
        {
            UIApplication.shared.open(twitterUrl!)
            
        } else {
            //opens current app in the app store if URL can't open
            UIApplication.shared.open(URL(string: "https://itunes.apple.com/in/app/twitter/id333903271?mt=8")!)
        }
    }
    
    @IBAction func facebookButton(_ sender: UIButton) {
        let facebookExtention = "fb://profile/1473315556"
        let facebookUrl = URL(string: facebookExtention)
        if UIApplication.shared.canOpenURL(facebookUrl! as URL)
        {
            UIApplication.shared.open(facebookUrl!)
            
        } else {
            //opens current app in the app store if URL can't open
            UIApplication.shared.open(URL(string: "https://itunes.apple.com/in/app/facebook/id284882215?mt=8")!)
        }
    }
    
    
    
    
    
}


