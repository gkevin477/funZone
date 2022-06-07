//
//  SignUpViewController.swift
//  funZone
//
//  Created by admin on 6/5/22.
//

import UIKit

class SignUpViewController: ViewController {

    @IBOutlet weak var createusernameText: UITextField!
    @IBOutlet weak var createpasswordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var isRemembered: UISwitch!
    
    let login = LogInViewController()
    var isNew: Bool = true
    
    @IBAction func submit(_ sender: Any){
        
        if(createusernameText.text != "" && createpasswordText.text != "")
        {
            login.getAllItems()
            
            
            for val in login.logs {
                isNew = true
                if(val.username == createusernameText.text){
                    isNew = false
                    break
                }
            }
            
            if(isNew){

                login.createItem(username: createusernameText.text!)
                login.savePassword(user: createusernameText.text!, password: createpasswordText.text!)
        
                guard let vc = storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController? else{
                    return
                }
        
                navigationController?.pushViewController(vc, animated: true)
                if(isRemembered.isOn){
                    UDM.shared.defaults.setValue(true, forKey: "Remember me")
                    UDM.shared.defaults.setValue(createusernameText.text, forKey: "username")
                }
            }
            errorLabel.text = "Username Is taken"
            return
        }
        errorLabel.text = "Username/Password is empty"
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNew = true

        // Do any additional setup after loading the view.
    }
    

}
