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
                        var loca = data!["loc"] as! NSDictionary
                        var locaObject = Localisation(longitude: loca["longitude"]as! Float , latitude: loca["latitude"]as! Float , heure: loca["heure"]as! String, date: loca["date"]as! String)
                        /*Localisation(longitude: data!["loc"]!!["longitude"] as! Float, latitude: Float(data!["loc"]!!["latitude"]) as! Float, heure: String(data!["loc"]!!["heure"]), date: String(data!["loc"]!!["date"]))*/
                        let ps = data!["pseudo"] as! String
                        var ami = Amis(pseudo: ps , position: locaObject)
                        NSNotificationCenter.defaultCenter().postNotificationName("updateLoc", object: ami)
                        
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