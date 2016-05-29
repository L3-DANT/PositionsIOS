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
            Connexion.getConnexionAsynchronously(request, pseudo: pseudo, motPasse: motDePasse){data in
                print("Asynchronously fetched \(data!.length) bytes")
                
                var pseudo = ""
                var token = ""
                
                do{
                    if let user = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                        print(user)
                        if(user["pseudo"] != nil && user["token"] != nil){
                            pseudo = (user["pseudo"] as? String)!
                            token = (user["token"] as? String)!
                        }
                    }
                    
                } catch let error as NSError{
                    print(error)
                }
                
                print("token after connexion : " + token)
                
                if(data!.length != 0){
                    print("Connexion réussie")
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(pseudo, forKey: "pseudo")
                    defaults.setValue(token, forKey: "token")
                    defaults.synchronize()
                    print("Sauvegarde utilisateur")
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("ConnexionToMap", sender: self)
                    })
                }
                else{
                    print("Mauvais pseudo ou mot de passe")
                    //self.Verif.text = "Mauvais pseudo ou mot de passe"
                }
            }
            
        }
    }
    

}
