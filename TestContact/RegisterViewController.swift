//
//  RegisterViewController.swift
//  etact
//
//  Created by Andrew Phillips on 8/28/17.
//  Copyright © 2017 Andrew Phillips. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repassword: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var snapchat: UITextField!
    @IBOutlet weak var instagram: UITextField!
    @IBOutlet weak var twitter: UITextField!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        if(firstName.text?.isEmpty)! ||
            (lastName.text?.isEmpty)! ||
            (email.text?.isEmpty)! ||
            (password.text?.isEmpty)! ||
            (phoneNumber.text?.isEmpty)! ||
            (snapchat.text?.isEmpty)! ||
            (instagram.text?.isEmpty)! ||
            (twitter.text?.isEmpty)!{
            //Display alert
            displayMessage(userMessage: "All fields are required.")
            return
        }
        if(password.text != repassword.text){
            //Display alert
            displayMessage(userMessage: "Passwords do not match.")
            return
        }
        
        //Activity indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        //HTTP request
        //PHP
        let fName = "FirstName="+firstName.text!
        let lName = "&LastName="+lastName.text!
        let e = "&Email="+email.text!
        let p = "&Password="+password.text!
        
        let pn = "&PhoneNumber="+phoneNumber.text!
        let sc = "&Snapchat="+snapchat.text!
        let insta = "&Instagram="+instagram.text!
        let twit = "&Twitter="+twitter.text!
        
        let deviceID = "&Device="+UIDevice.current.identifierForVendor!.uuidString
        
        let myUrl = URL(string: "http://anphillips.com/eTact/register.php")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        let postString = fName+lName+e+p+pn+sc+insta+twit+deviceID
        
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
                    let pof = parseJSON["pof"] as? Int
                    if pof! == 1{
                        self.displayMessage(userMessage: "Successfully registered.")
                    }
                    else {
                        self.displayMessage(userMessage: "Failed.")
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
    //bulit in method, act whenever the user touches screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}
