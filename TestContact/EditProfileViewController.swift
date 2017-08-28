//
//  EditProfileViewController.swift
//  etact
//
//  Created by Andrew Phillips on 8/27/17.
//  Copyright © 2017 Andrew Phillips. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var snapchatEdit: UITextField!
    
    @IBAction func submitButton(_ sender: UIButton) {
        
    }
    //bulit in method, act whenever the user touches screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}
