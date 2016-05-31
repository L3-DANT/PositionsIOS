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
    
    
   override func viewDidLoad() {
  
        super.viewDidLoad()
    
    }
    
    
    @IBAction func ActionEnregistrer(sender: AnyObject) {
        
        let PseudoString = Pseudo.text!
        let MailString = Mail.text!
        let MdP = MotPasse.text!
        let VerifPasse = MotPasse1.text!
        
        //"http://92.170.201.10/Positions/utilisateur/inscription"
        let request = NSMutableURLRequest(URL: NSURL(string: "http://92.170.201.10/Positions/utilisateur/inscription")!)

        if (VerifMotPass(MdP, MotPasse1String: VerifPasse)){
        EnregistrementUtilisateur.getDataAsynchronously(request, motPasse: MdP, mail: MailString, pseudo: PseudoString){data in
            print("Asynchronously fetched \(data!.length) bytes")
            
            var pseudo = ""
            var token = ""
            
            do{
                if let user = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                    pseudo = (user["pseudo"] as? String)!
                    token = (user["token"] as? String)!
                }
                
            } catch let error as NSError{
                print(error)
            }
            
            print("token after inscription : " + token)
            
            if(data!.length != 0){
                self.Verif.text = "Inscription réussie"
                print("Inscription réussie")
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setValue(pseudo, forKey: "pseudo")
                defaults.setValue(token, forKey: "token")
                defaults.synchronize()
                print("Sauvegarde utilisateur")
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.performSegueWithIdentifier("InscriptionToMap", sender: self)
                })
            }
            else{
                print("Pseudo Deja existant")
                self.Verif.text = "Pseudo Deja existant"
            }
        }
        }
        
        
    }
    
    
    
    func VerifMotPass(MotPasseString:String, MotPasse1String:String) -> Bool {
        if(MotPasseString == MotPasse1String){
            self.Verif.text = ""
            return true
        
        }else {
            self.Verif.text = "Vérification du mot de passe incorrecte"
            return false
        }
    }


}