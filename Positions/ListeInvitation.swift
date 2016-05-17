//
//  ListeInvitation.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation


class ListeInvitation{
    
    class Invitation{
        let pseudo: String
        
        init(pseudo:String){
            self.pseudo = pseudo
        }
    }
    
    let donnee = [
        Invitation(pseudo:"Davy"),
        Invitation(pseudo:"Xue")
    ]
        
}