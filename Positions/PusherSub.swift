//
//  PusherSub.swift
//  Positions
//
//  Created by cai xue on 29/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation
import PusherSwift

class PusherSub{

    static func subscribe(){
        let pusher = Pusher(
            key: "f145cb57089f977c5857",
            options: ["cluster": "eu"]
        )
        print("hello")
        
        let arrayUser = ["seb", "davy", "shamil"]
        
        let defaults = NSUserDefaults.standardUserDefaults()
        NSUserDefaults.standardUserDefaults().setObject(arrayUser, forKey: "friends")
        
        
        var test: [String] = []
        defaults.objectForKey("friends") as! NSArray
        for element in test {print(element)}
        test.append("test")
        NSUserDefaults.standardUserDefaults().setObject(test, forKey: "friends")
        
    
        /*
        if let test = defaults.objectForKey("friends"){
            for element in test {print(element)}
        }*/
        
        //tqblequ de chqnnel
        //let channel2 = pusher.subscribe("mako")
        var channelArray: [PusherChannel] = []
        for(var i = 0; i < arrayUser.count; i++){
            let channel = pusher.subscribe(arrayUser[i])
            channelArray.append(channel)
        }
        for(var i = 0; i < channelArray.count; i++){
            channelArray[i].bind("update", callback: {(data: AnyObject?) -> Void in
            /*if let location = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                print("message received: (data)" )
            }*/
                print(data!["pseudo"])
                print(data!["loc"])
                print(data!["loc"] as! NSDictionary)
                print(data!["loc"]!!["latitude"])
                
            })
        }
        //add les updates dans la base
        //faire boucle quand liste amis dispo 
        
        pusher.connect()
        
    }

}