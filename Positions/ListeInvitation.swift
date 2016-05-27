//
//  ListeInvitation.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation


class ListeInvitation{
    
    class Invitation{
        let pseudo: String
        
        init(pseudo:String){
            self.pseudo = pseudo
        }
    }
    
    let donnee = [
        Invitation(pseudo:"Davy"),
        Invitation(pseudo:"Xue")
    ]
    
    //var donnee = Invitation(pseudo:recupererListeInvitation("Moi"))
    //var liste = recupererListeInvitation("Moi")
    
    
    
    func recupererListeInvitation(pseudo:String){
        
        let url = "http://134.157.245.93:8080/Positions/invitation/recupInvits"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["pseudo":pseudo]
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            print(error)
        }
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let success = json["success"] as? Int
                    print("Success: \(success)")
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        task.resume()
    }

  
}
