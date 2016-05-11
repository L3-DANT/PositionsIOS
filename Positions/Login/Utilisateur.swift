//
//  Utilisateur.swift
//  Positions
//
//  Created by Anjaneya on 07/04/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation


class Utilisateur {
    
    let nom:String
    let prenom:String
    let motDePasse:String
    let pseudo:String
    let token:String
    var local:Localisation
 
    init(nom: String, prenom:String, motDePasse:String, pseudo:String, token:String, localisation:Localisation) {
        self.nom = nom
        self.prenom = prenom
        self.motDePasse = motDePasse
        self.pseudo = pseudo
        self.token = token
        self.local = localisation
    }
    
    //func description () -> String {
        
    //}
    
    func affiche(){
        print("Nom : " + self.nom)
        print("prenom : " + self.prenom)
        print("pseudo : " + self.pseudo)
        print("mots Passe : " + self.motDePasse)
        print("token: " + self.token)
        
    }
    
    
}  