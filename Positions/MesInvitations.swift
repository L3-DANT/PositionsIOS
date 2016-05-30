//
//  MesAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class MesInvitations: UITableViewController {
    
    let data = [Invitation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return data.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellule", forIndexPath: indexPath) as! MesInvitationsCell
        
        //let entre = data.donnee[indexPath.row]
        
        //cell.nomCell.text = entre.pseudo
        
        
        return cell
    }
    
    func recupererListeInvitation(pseudo:String) -> Array<String>{
        let url = "http://134.157.24.6:8080/Positions/invitation/recupInvits"
        //"http://92.170.201.10:8080/Positions/invitation/recupInvits"
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
        
        let res = [String]()
        
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            let invit = Invitation()
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    print(json)
                    
                    if let invitations = json as? [[String: AnyObject]]{
                        for invitation in invitations{
                            if let demandeur = invitation["demandeur"] as? String{
                                invit.setDemandeur(demandeur)
                            }
                            if let concerne = invitation["concerne"] as? String{
                                invit.setDemandeur(concerne)
                            }
                            if let date = invitation["date"] as? NSDate{
                                invit.setDate(date)
                            }
                            if let accept = invitation["accept"] as? String{
                                invit.setDemandeur(accept)
                            }
                        }
                        
                    }
                }
                
                /*
                 //let success = json["success"] as? Invitation
                 for index: [key: AnyObject, value : AnyObject] in json{
                 let pseudo = index["pseudo"] as? String
                 let donnee = Invitation(pseudo)
                 }
                 //print("Success: \(success)")
                 } else {
                 let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                 print("Error could not parse JSON: \(jsonStr)")
                 }*/
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        task.resume()
        return res
    }
}
