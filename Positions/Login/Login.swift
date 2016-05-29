//
//  Login.swift
//  Positions
//
//  Created by Anjaneya on 17/03/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class Login: UITableViewController {
    

    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnPasswordView: UIButton!
    
    @IBOutlet weak var loginView: UIButton!
    
    var passwordString:String!
    var usernamesString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let token = defaults.stringForKey("token"){
            print("connexion " + token)
        
        }
        passwordViewConfig()
      //  loginViewConfig()
        
        
    }
    // fonction passwordView
    func passwordViewConfig(){
        btnPasswordView.setImage(UIImage(named: "EyeCloseIcon"), forState: UIControlState.Normal)
    }
 
    
    // Action change l'image passwordView
    @IBAction func btnPasswordViewAction(sender: AnyObject) {
        passwordString = txtPassword.text
        if btnPasswordView.currentImage!.isEqual(UIImage(named: "EyeCloseIcon")){
            btnPasswordView.setImage(UIImage(named: "EyeOpenIcon"), forState: UIControlState.Normal)
            txtPassword.secureTextEntry = false
            txtPassword.text = nil
            txtPassword.text = passwordString
        }else{
            btnPasswordView.setImage(UIImage(named: "EyeCloseIcon"),forState: UIControlState.Normal)
            txtPassword.secureTextEntry = true
            txtPassword.text = passwordString
            
        }
    }
    
    
    // redirige la cellule username a la cellune password
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath:NSIndexPath){
        if indexPath.section == 0 && indexPath.row == 0 {
            txtUsername.becomeFirstResponder()
        }
        if indexPath.section == 0 && indexPath.row == 0 {
            txtPassword.becomeFirstResponder()
        }
    }
    
    
    // fonction config return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtUsername {
            textField.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            
        }
        if textField == txtPassword {
            usernamesString = txtUsername.text
            passwordString = txtPassword.text
            if usernamesString.isEmpty || passwordString.isEmpty {
                textField.resignFirstResponder()
                txtUsername.becomeFirstResponder()
            }else {
                loginAction(self)
            }
            
        }
        return true
    }

    

    
    @IBAction func loginAction(sender: AnyObject) {
    
        
        let pseudo = txtUsername.text!
        let motDePasse = txtPassword.text!
        
        let pseudoAlert = UIAlertController(title: "Error", message:
            "Le pseudo est obligatoire!", preferredStyle: UIAlertControllerStyle.Alert)
        pseudoAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        let pwdAlert = UIAlertController(title: "Error", message:
            "Le mot de passe est obligatoire!", preferredStyle: UIAlertControllerStyle.Alert)
        pwdAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        let errorAlert = UIAlertController(title: "Error", message:
            "Connexion error!", preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.Default,handler: nil))

    
        
        if pseudo.isEmpty {
            self.presentViewController(pseudoAlert, animated: true, completion: nil)
        } else if motDePasse.isEmpty {
            self.presentViewController(pwdAlert, animated: true, completion: nil)
        } else {
            
            let url = "http://92.170.201.10/Positions/utilisateur/connexion"
            let request = NSMutableURLRequest(URL: NSURL(string: url)!)
            
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let params = ["pseudo":pseudo, "motDePasse":motDePasse] as Dictionary<String, String>
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            } catch {
                print(error)
            }
            
            let task = session.dataTaskWithRequest(request) { data, response, error in
                guard data != nil else {
                    print("no data found: \(error)")
                    return
                }
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        let success = json["pseudo"] as? String
                        print(json)
                        print("Success: \(success)")
                        print((json["localisation:date"] as? String))
                        
                    } else {
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            self.presentViewController(errorAlert, animated: true, completion: nil)
                     
                        if (jsonStr == true){
                            self.performSegueWithIdentifier("LocaliserMap", sender: self)
                        }
                    }
                } catch let parseError {
                    print(parseError)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        self.presentViewController(errorAlert, animated: true, completion: nil)
                      
                    if (jsonStr == true){
                        self.performSegueWithIdentifier("LocaliserMap", sender: self)
                    }
                }
            }
            task.resume()
        }
    }
    

}
