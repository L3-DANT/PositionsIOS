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
        
        if let loadedData = NSUserDefaults().dataForKey("friends") {
            loadedData
            if let loadedPerson = NSKeyedUnarchiver.unarchiveObjectWithData(loadedData) as? [Amis] {
                print("-------------------------------------")
                var channelArray: [PusherChannel] = []
                for(var i = 0; i < loadedPerson.count; i += 1){
                    let channel = pusher.subscribe(loadedPerson[i].pseudo)
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
            }
        }
        
        
        
    
        /*
        if let test = defaults.objectForKey("friends"){
            for element in test {print(element)}
        }*/
        
        //tqblequ de chqnnel
        //let channel2 = pusher.subscribe("mako")
                //add les updates dans la base
        //faire boucle quand liste amis dispo 
        
        pusher.connect()
        
    }

}