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
    var VerifString:String!
    
    
    
   override func viewDidLoad() {
  
        super.viewDidLoad()
    
    }
    
    
    @IBAction func ActionEnregistrer(sender: AnyObject) {
        
        PseudoString = Pseudo.text!
        MailString = Mail.text!
        MotPasseString = MotPasse.text!
        Motpasse2String = MotPasse1.text!
        
        
        if (VerifMotPass(MotPasseString, MotPasse1String: Motpasse2String)){
            VerifString = self.Verif.text!
            if(EnregistrementUtilisateur.enregistrement(MotPasseString,motPasse1: Motpasse2String,mail: MailString,pseudo: PseudoString, verif: VerifString)){
                self.Verif.text = "Inscription réussie"
            }else{
                self.Verif.text = "Pseudo Deja existant"
            }
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