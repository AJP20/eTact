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
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
