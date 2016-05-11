//
//  Inscription.swift
//  Positions
//
//  Created by Anjaneya on 13/04/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation
import UIKit


class Inscription: UIViewController {
    
    
    
    @IBOutlet weak var Pseudo: UITextField!
    
    @IBOutlet weak var Mail: UITextField!
    
    @IBOutlet weak var MotPasse: UITextField!
    
    @IBOutlet weak var MotPasse1: UITextField!

    @IBOutlet weak var Verif: UILabel!
    
    var PseudoString:String!
    var MailString:String!
    var MotPasseString:String!
    var Motpasse2String:String!
    
    
    
   override func viewDidLoad() {
  
        super.viewDidLoad()
    
    }
    
    
    @IBAction func ActionEnregistrer(sender: AnyObject) {
        
        PseudoString = Pseudo.text!
        MailString = Mail.text!
        MotPasseString = MotPasse.text!
        Motpasse2String = MotPasse1.text!

        if (self.VerifMotPass(MotPasse.text!, MotPasse1String: MotPasse1.text!)){
            let url = "http://134.157.245.93:8080/Positions/utilisateur/inscription"
            let request = NSMutableURLRequest(URL: NSURL(string: url)!)
            
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let params = ["nom":" ", "prenom":" ","pseudo":Pseudo.text!, "motDePasse":MotPasse.text!,"mail":Mail.text!] as Dictionary<String, String>
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            } catch {
                print(error)
            }
            
            let task = session.dataTaskWithRequest(request) { data, response, error in
                guard data != nil else {
                   // print("no data found: \(error)")
                    return
                }
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        //   let success = json["pseudo"] as? String
                        // print("Success: \(success)")
                        //print((json["localisation:date"] as? String))
                       // print(json)
                    self.Verif.text = ""
                      
                        
                    } else {
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        //print("Error could not parse JSON: \(jsonStr)")
                        if (jsonStr == true){
                           // print(jsonStr)
                        }
                        
                        
                    }
                } catch let parseError {
                    print(parseError)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    //print(jsonStr)
                
                    if((jsonStr ?? false) != nil){
                       self.Verif.text = "Pseudo deja existant"
                    }
                    
                    
                    if (jsonStr == true){
                      //  print("Connexion reussie !");
                    }
                }
            }
            task.resume()

        }
        
    }

    
    func VerifMotPass(MotPasseString:String, MotPasse1String:String) -> Bool {
        if(MotPasseString == MotPasse1String){
            self.Verif.text = " "
            return true
        
        }else {
            self.Verif.text = "Mots de passe incorrect"
            return false
        }
    }


}