//
//  Localisation.swift
//  Positions
//
//  Created by Anjaneya on 07/04/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation

class Localisation {
    let longitude:Float
    let latitude:Float
    let heure:String
    let date:String
    

    init(longitude:Float, latitude:Float, heure:String, date:String){
        
        self.latitude = latitude
        self.longitude = longitude
        self.heure = heure
        self.date = date
    }
    
}