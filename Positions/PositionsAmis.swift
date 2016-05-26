//
//  PositionsAmis.swift
//  Positions
//
//  Created by cai xue on 25/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation
import MapKit

class PositionsAmis: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var nom:String
    
    
    /*
    init(lo:Float, la:Float) {
        self.longitude=lo
        self.latitude=la
    }*/
    
 
    
    init(cll:CLLocationCoordinate2D, nom:String) {
        self.coordinate=cll
        self.nom=nom
    }
    
   /* init(lo:CLLocationDegrees, la:CLLocationDegrees){
        self.longitude = lo
        self.latitude = la
    }
 */
    
}