//
//  AddInvitation.swift
//  Positions
//
//  Created by cai xue on 31/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation


class AddInvitation{
    
    static func send(request: NSMutableURLRequest, completion: NSData? -> ()){
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //let params = ["pseudo":pseudo] as Dictionary<String, String>
        let params = []
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            print(error)
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            completion(data)
        })
        task.resume()
        
    }
    
}