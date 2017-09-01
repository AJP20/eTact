//
//  SignInViewController.swift
//  etact
//
//  Created by Andrew Phillips on 8/28/17.
//  Copyright © 2017 Andrew Phillips. All rights reserved.
//

import UIKit

var currentId: String!

class SignInViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    func callHome(){
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    
    @IBAction func signInButton(_ sender: Any){
        
        if(email.text?.isEmpty)! ||
            (email.text?.isEmpty)! {
            //Display alert
            displayMessage(userMessage: "All fields are required.")
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
        let e = "&email="+email.text!
        let p = "&password="+password.text!
        let myUrl = URL(string: "http://anphillips.com/eTact/signin.php")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        let postString = e+p
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
                    currentId = parseJSON["id"] as? String
                    print(currentId)
                    if pof! > 0{
                        DispatchQueue.main.async {
                            self.callHome();
                        }
                    }
                    else {
                        self.displayMessage(userMessage: "Failed sign in.")
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
