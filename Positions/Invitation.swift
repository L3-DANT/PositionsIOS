//
//  ListeInvitation.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation



class Invitation{
        var demandeur: String
        var concerne: String
        var date: String
        var accept: String
        
        init(){
            self.demandeur = ""
            self.concerne = ""
            self.date = ""
            self.accept = "EN_ATTENTE"
        }
        
        init(demandeur:String, concerne: String, date: String, accept: String){
            self.demandeur = demandeur
            self.concerne = concerne
            self.date = date
            self.accept = accept
        }
        
        func setDemandeur(demandeur:String){
            self.demandeur = demandeur
        }
        
        func setConcerne(concerne:String){
            self.concerne = concerne
        }
        func setDate(date:String){
            self.date = date
        }
        func setAccept(accept:String){
            self.accept = accept
        }

        
    
    //let donnee = [demandeur:"Davy", demandeur:"Xue"]
    
    //var donnee: [String]
    //donnee = recupererListeInvitation("dd")
    
    
    

}