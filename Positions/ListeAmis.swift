//
//  ListeAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation

class ListeAmis{
    
    class Amis{
        let pseudo: String
        
        init(pseudo:String){
            self.pseudo = pseudo
        }
    }
    
    let donnee = [
        Amis(pseudo:"Sebastien"),
        Amis(pseudo:"Lux")
    ]
    
}