//
//  ProfileViewController.swift
//  etact
//
//  Created by Andrew Phillips on 9/17/17.
//  Copyright © 2017 Andrew Phillips. All rights reserved.
//

import UIKit
import Contacts

class ProfileViewController: UIViewController {
    var fname=""
    var lname=""
    var id=""
    var pnum=""
    var snap=""
    var insta=""
    var twit=""
    
    @IBOutlet weak var profileName: UILabel!

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getUser() {
        //Activity indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        //HTTP request
        //PHP
        let d = "&Device="+peripheralId
        let myUrl = URL(string: "http://anphillips.com/eTact/getuser.php")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        let postString = d
        print("Post: "+postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print("error=\(String(describing: error))")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    self.fname = (parseJSON["firstname"] as? String)!
                    self.lname = (parseJSON["lastname"] as? String)!
                    self.id = (parseJSON["id"] as? String)!
                    let pof = parseJSON["pof"] as? Int
                    if pof! > 0{
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.profileName.text = self.fname+" "+self.lname
                            print("Firstname loaded: "+self.fname)
                            print("Lastname loaded: "+self.lname)
                            print("id loaded: "+self.id)
                            print("From device: "+peripheralId)
                            self.getProfile()
                        })
                    }
                    else {
                        self.displayMessage(userMessage: "Failed to load users data.")
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getProfile() {
        //Activity indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        //HTTP request
        //PHP
        let myUrl = URL(string: "http://anphillips.com/eTact/getprofile.php")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        let postString = "&id="+id
        print("Post: "+postString)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            if error != nil
            {
                self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later.")
                print("error=\(String(describing: error))")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json {
                    self.pnum = (parseJSON["phonenumber"] as? String)!
                    self.snap = (parseJSON["snapchat"] as? String)!
                    self.insta = (parseJSON["instagram"] as? String)!
                    self.twit = (parseJSON["twitter"] as? String)!
                    let pof = parseJSON["pof"] as? Int
                    if pof! > 0{
                        DispatchQueue.main.async(execute: { () -> Void in
                            print("Phone number loaded: "+self.pnum)
                            print("Snap loaded: "+self.snap)
                            print("Insta loaded: "+self.insta)
                            print("Insta loaded: "+self.twit)
                        })
                    }
                    else {
                        self.displayMessage(userMessage: "Failed to load users data.")
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView){
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func displayMessage(userMessage:String) -> Void{
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:"Alert", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title:"OK", style: .default){(action:UIAlertAction!)in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }
    
    @IBAction func snapchatButton(_ sender: UIButton) {
        let snapchatExtention = "snapchat://add/"+snap
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
        let instagramExtention = "instagram://user?username="+insta
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
        let twitterExtention = "twitter://user?screen_name="+twit
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
    
    
    
    @IBAction func phoneNumberButton(_ sender: UIButton) {
        
        // Creating a mutable object to add to the contact
        let contact = CNMutableContact()
        
        contact.givenName = fname
        contact.familyName = lname
        
        //let homeEmail = CNLabeledValue(label:CNLabelHome, value:"ajp20@live.com")
        //contact.emailAddresses = [homeEmail]
        
        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue:pnum))]
        
        /*let homeAddress = CNMutablePostalAddress()
        homeAddress.street = "32 Fraser Dr"
        homeAddress.city = "Salem"
        homeAddress.state = "NH"
        homeAddress.postalCode = "03079"
        contact.postalAddresses = [CNLabeledValue(label:CNLabelHome, value:homeAddress)]
        
        let birthday = NSDateComponents()
        birthday.day = 30
        birthday.month = 4
        birthday.year = 1997  // You can omit the year value for a yearless birthday
        contact.birthday = birthday as DateComponents*/
        
        // Saving the newly created contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier:nil)
        try! store.execute(saveRequest)
    }


}
