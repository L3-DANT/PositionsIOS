//
//  Utilisateur.swift
//  Positions
//
//  Created by Anjaneya on 07/04/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation


class Utilisateur: Localisation {
    
    let nom:String
    let prenom:String
    let motDePasse:String
    let pseudo:String
    let token:String
 
    init(nom: String, prenom:String, motDePasse:String, pseudo:String, latitude:Float, longitude:Float, heure:String, date:String, token:String) {
        self.nom = nom
        self.prenom = prenom
        self.motDePasse = motDePasse
        self.pseudo = pseudo
        self.token = token
        super.init(longitude:longitude, latitude:latitude, heure:heure, date:date)
    }
    
    func affiche(){
        print("Nom : " + self.nom)
        print("prenom : " + self.prenom)
        print("pseudo : " + self.pseudo)
        print("mots Passe : " + self.motDePasse)
        print("token: " + self.token)
        print("Longitude : ",  super.longitude)
        print("latitude : ",  super.latitude)
        print("Last date : ",  super.date)
        print("Last time : ",  super.heure)
    }
    
    
}  