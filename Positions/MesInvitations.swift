//
//  MesAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class MesInvitations: UITableViewController {
    
    let data = ListeInvitation()
    
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

        return data.donnee.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellule", forIndexPath: indexPath) as! MesInvitationsCell
        
        let entre = data.donnee[indexPath.row]
        
        cell.nomCell.text = entre.pseudo
        
        
        return cell
    }
    
    
}
