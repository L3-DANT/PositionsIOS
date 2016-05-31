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
        
        //let entre = data.donnee[indexPath.row]
        
        //cell.nomCell.text = entre.pseudo
        
        
        return cell
    }
    
    func recupererListeInvitation() -> Array<Invitation>{
        //let url = "http://134.157.24.6:8080/Positions/invitation/recupInvits"
        var url = ""
        let defaults = NSUserDefaults.standardUserDefaults()
        var res = []
        if let pseudo = defaults.stringForKey("pseudo"){
            url = "http://92.170.201.10/Positions/invitation/recupInvits?pseudo=" + pseudo
        }
        print(url)
        //let url = "http://134.157.122.100:8080/Positions/utilisateur/connexion"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        InvitationService.send(request){data in
            print("Asynchronously fetched \(data!.length) bytes")
            
            do{
                if let answer = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray{
                    print(answer[0]["accept"])
                    
                }
                
            } catch let error as NSError{
                print(error)
            }
            
            
        }
        return res as! Array<Invitation>
    }
}
