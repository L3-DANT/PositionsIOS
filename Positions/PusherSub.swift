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
    
        let channel = pusher.subscribe("kll")
        let channel2 = pusher.subscribe("mako")
        
        channel.bind("update", callback: {(data: AnyObject?) -> Void in
            /*if let location = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                print("message received: (data)" )
            }*/
            print(data!["pseudo"])
            print(data!["loc"])
            print(data!["loc"] as! NSDictionary)
            print(data!["loc"]!!["latitude"])
        })
        
        //add les updates dans la base
        //faire boucle quand liste amis dispo 
        
        pusher.connect()
        
    }

}