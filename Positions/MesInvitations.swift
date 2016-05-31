//
//  MesAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class MesInvitations: UITableViewController {
    
    var data = [Invitation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recupererListeInvitation()
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
        
        let entre = data[indexPath.row]
        
        cell.nomCell.text = entre.concerne
        cell.dateCell.text = entre.date
        
        
        return cell
    }
    
    func recupererListeInvitation(){
        //let url = "http://134.157.24.6:8080/Positions/invitation/recupInvits"
        var url = ""
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let pseudo = defaults.stringForKey("pseudo"){
            //url = "http://134.157.121.10:8080/Positions/invitation/recupInvits?pseudo=" + pseudo
            url = "http://92.170.201.10/Positions/invitation/recupInvits?pseudo=" + pseudo
        }
        print(url)
        //let url = "http://134.157.122.100:8080/Positions/utilisateur/connexion"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        InvitationService.send(request){data in
            print("Asynchronously fetched \(data!.length) bytes")
            
            do{
                if let answer = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray{
                    for(var i = 0; i<answer.count; i++){
                        let demandeur = answer[i]["demandeur"] as! String
                        let concerne = answer[i]["concerne"] as! String
                        let date = answer[i]["date"] as! String
                        let accept = answer[i]["accept"] as! String
                        let invit = Invitation(demandeur: demandeur, concerne: concerne, date: date, accept: accept)
                        self.data.append(invit)
                        print(demandeur + " " + concerne + " " + accept + " " + date )
                    }
                    print(self.data)
                }
                
            } catch let error as NSError{
                print(error)
            }
            
            
        }
        //print(self.data[0])
    }
}
