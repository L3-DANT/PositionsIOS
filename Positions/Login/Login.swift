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

    
    //function config bckgrnd img login button
   /* func loginViewConfig() {
        let imageBackground = makeImagewithColor(UIColor(red: 0/255, green: 146/255, blue: 69/255, alpha: 1.0))
        loginView.setBackgroundImage(imageBackground, forState: UIControlState.Normal)
        loginView.tintColor = UIColor.whiteColor()
    } */
    
    @IBAction func loginAction(sender: AnyObject) {
    
        let url = "http://132.227.125.76:8080/Positions/utilisateur/inscription"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["nom":txtUsername.text!, "prenom":txtPassword.text!] as Dictionary<String, String>
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
                    let success = json["success"] as? Int
                    print("Success: \(success)")
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        task.resume()
        
    }
}
