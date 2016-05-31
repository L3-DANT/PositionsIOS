//
//  Deconnexion.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation
import UIKit

class Deconnexion: UINavigationController{
    
    
    override func viewDidLoad() {
        print("deconnexion")
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey("pseudo")
        userDefaults.removeObjectForKey("token")
        dispatch_async(dispatch_get_main_queue(), {
            self.performSegueWithIdentifier("afterDeconnexion", sender: self)
        })
        
        
    }
}