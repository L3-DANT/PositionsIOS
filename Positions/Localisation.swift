//
//  Localisation.swift
//  Positions
//
//  Created by Anjaneya on 07/04/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation

class Localisation: NSObject, NSCoding{
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
    
    required convenience init(coder aDecoder: NSCoder){
        let long = aDecoder.decodeFloatForKey("longitude")
        let lat = aDecoder.decodeFloatForKey("latitude")
        let date = aDecoder.decodeObjectForKey("date") as! String
        let heure = aDecoder.decodeObjectForKey("heure") as! String
        self.init(longitude: long, latitude : lat, heure : heure, date: date )
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeFloat(longitude, forKey: "longitude")
        aCoder.encodeFloat(latitude, forKey: "latitude")
        aCoder.encodeObject(heure, forKey: "heure")
        aCoder.encodeObject(date, forKey: "date")
    }
    
}