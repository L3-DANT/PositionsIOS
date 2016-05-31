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
    var title: String?
    
    
    
    init(cll:CLLocationCoordinate2D, nom:String) {
        self.coordinate=cll
        self.title=nom
    }
    
    func setCoordonnee(cll: CLLocationCoordinate2D){
        self.coordinate = cll
    }
    
    
}