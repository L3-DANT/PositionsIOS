//
//  ListeAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation
import CoreLocation


class Amis: NSObject, NSCoding{
    let pseudo: String
    var position : Localisation
        
    init(pseudo:String,position:Localisation){
        self.pseudo = pseudo
        self.position = position
    }
    
    required convenience init(coder aDecoder: NSCoder){
        let pseudo = aDecoder.decodeObjectForKey("pseudo") as! String
        let position = aDecoder.decodeObjectForKey("position") as! Localisation
        self.init(pseudo : pseudo, position: position )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(pseudo, forKey: "pseudo")
        aCoder.encodeObject(position, forKey: "position")
    }
}
    

