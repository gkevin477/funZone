//
//  LogInViewController.swift
//  funZone
//
//  Created by admin on 6/5/22.
//

import UIKit
import CoreData

class LogInViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var isRemembered: UISwitch!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var logs: [Login] = []
    
    

    
    
    
    @IBAction func logInButton(_ sender: Any){

        
        getAllItems()
        for val in logs{
            if (userNameText.text! == val.username){
                let password = getPassword(username: val.username!)
                if(password == passwordText.text!){
                    
                    if(isRemembered.isOn){
                        UDM.shared.defaults.setValue(true, forKey: "Remember me")
                        UDM.shared.defaults.setValue(userNameText.text, forKey: "username")
                    }
                    else{
                        UDM.shared.defaults.setValue(false, forKey: "Remember me")
                        
                    }
                    guard let vc = storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController? else{
                        return
                    }
                    navigationController?.pushViewController(vc, animated: true)
                    
                    print("Account Successfuly Loged In")
                    return
                }
                errorLabel.text = "Password Is Incorrect"
                return
            }
        }
        errorLabel.text = "Failed Loging In to Account"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let value = UDM.shared.defaults.value(forKey: "Remember me") as? Bool{
            if(value){
                if let user = UDM.shared.defaults.value(forKey: "username") as? String{
                    userNameText.text = user
                    isRemembered.setOn(true, animated: true)
                }
            }
        }
        
    }
    
    
    
    
    
    //Core Data
    func getAllItems(){
        do{
        logs = try context.fetch(Login.fetchRequest())
        
        
        }catch{
            print("Unable to find Items")
        }
    }
    
    func createItem(username: String){
        let newItem = Login(context: context)
        newItem.username = username
        do{
            try context.save()
        }
        catch{
            print("Unable to save context")
        }
    }
    
    func deleteItem(item: Login){
        context.delete(item)
        do{
            try context.save()
        }
        catch{
            print("Unable to save context")
        }
    }
    
    
    
    
    
    
    
    // Password
    func getPassword(username: String) -> String{
        guard let data = KeychainManager.get(service: "SaveData", account: username) else{
            print("Failed to read password")
            return ""
        }
        
        let password = String(decoding: data, as: UTF8.self)
        return password
    }
    
    func savePassword(user: String, password: String){
        do{
            try KeychainManager.save(service: "SaveData", account: user, password: password.data(using: .utf8) ?? Data())
            
            
            
        }
        catch{
            print(error)
        }
        
    }


}

class KeychainManager{
    enum KeychainError: Error{
        case duplucateEntry
        case unknown(OSStatus)
    }
    
    static func save(service: String, account: String, password: Data) throws{
        // service, account, password, class, data
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard(status != errSecDuplicateItem) else{
            throw KeychainError.duplucateEntry
        }
        
        guard status == errSecSuccess else{
            throw KeychainError.unknown(status)
        }
        
        print("save")
        
    }
    
    
    static func get(service: String, account: String) -> Data?{
        //service, account, class, return-data, matchlimit
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        print("Read Status: \(status)")
        
        return result as? Data
    }
}
