//
//  ListeAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation
import CoreLocation

class ListeAmis{
    
    class Amis{
        let pseudo: String
        var position : CLLocationCoordinate2D
        
        init(pseudo:String,position:CLLocationCoordinate2D){
            self.pseudo = pseudo
            self.position = position
        }
    }
    
    let donnee = [
        Amis(pseudo:"Sebastien",position:CLLocationCoordinate2D(latitude: 48.8,longitude: 2.35)),
        Amis(pseudo:"Lux",position:CLLocationCoordinate2D(latitude: 48.832,longitude: 2.3445)),
        Amis(pseudo:"Maxime",position:CLLocationCoordinate2D(latitude: 48.7132,longitude: 2.13445))
    ]
    
   
}