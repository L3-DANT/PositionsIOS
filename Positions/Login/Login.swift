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
    
        let url = "http://134.157.245.93:8080/Positions/utilisateur/inscription"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["nom":txtUsername.text!, "prenom":txtPassword.text!,"pseudo":"Mp24qzasfdsqqdp", "motDePasse":"AZECODE"] as Dictionary<String, String>
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
                    print("Success: \(success)")
                    print((json["localisation:date"] as? String))
                    // print(json)
                    //self.extract_json_data(json)
                  
                  /*  let user = Utilisateur(nom: (json["nom"] as? String)!, prenom: (json["prenom"] as? String)!, motDePasse: (json["motDePasse"] as? String)!, pseudo: (json["pseudo"] as? String)!, latitude: (json["latitude"] as? Float)!, longitude: (json["longitude"] as? Float)!, heure: (json["heure"] as? String)!, date: (json["date"] as? String)!, token: (json["token"] as? String)!)
                   
                    user.affiche()
                     */
                    
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                    if (jsonStr == true){
                        print("Connexion reussie !");
                    }
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                if (jsonStr == true){
                    print("Connexion reussie !");
                }
            }
        }
        task.resume()
      
        
    }
   

}
