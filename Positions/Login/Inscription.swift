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
    /*
    var PseudoString:String!
    var MailString:String!
    var MotPasseString:String!
    var Motpasse2String:String!
    var VerifString:String!
    */
    
    
   override func viewDidLoad() {
  
        super.viewDidLoad()
    
    }
    
    
    @IBAction func ActionEnregistrer(sender: AnyObject) {
        
        let PseudoString = Pseudo.text!
        let MailString = Mail.text!
        let MdP = MotPasse.text!
        let VerifPasse = MotPasse1.text!
        
        var transition = false
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://92.170.201.10/Positions/utilisateur/inscription")!)
        if (VerifMotPass(MdP, MotPasse1String: VerifPasse)){
        EnregistrementUtilisateur.getDataAsynchronously(request, motPasse: MdP, mail: MailString, pseudo: PseudoString){data in
            print("Asynchronously fetched \(data!.length) bytes")
            //let dataString = String(data: NSData!, encoding: NSUTF8StringEncoding) as String?
            
            do{
                let test = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                print(test)
                
            } catch let error as NSError{
                print(error)
            }
                
            if(data!.length != 0){
                self.Verif.text = "Inscription réussie"
                print("Inscription réussie")
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
        
        
        /*
        if (VerifMotPass(MdP, MotPasse1String: VerifPasse)){
            if(EnregistrementUtilisateur.enregistrement(MdP,
                                                        motPasse1: VerifPasse,
                                                        mail: MailString,
                                                        pseudo: PseudoString)){
                self.Verif.text = "Inscription réussie"
                performSegueWithIdentifier("InscriptionToMap", sender: nil)
                //on fait la transistion avec le segue
            }else{
                self.Verif.text = "Pseudo Deja existant"
            }
        }*/
        
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