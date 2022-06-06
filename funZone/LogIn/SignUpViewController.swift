//
//  SignUpViewController.swift
//  funZone
//
//  Created by admin on 6/5/22.
//

import UIKit

class SignUpViewController: LogInViewController {

    @IBOutlet weak var createusernameText: UITextField!
    @IBOutlet weak var createpasswordText: UITextField!
    
    
    
    
    
    
    @IBAction func submit(_ sender: Any){
        createItem(username: createusernameText.text!)
        savePassword(user: createusernameText.text!, password: createpasswordText.text!)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
