//
//  MesAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class MesAmis: UITableViewController {
    
    let data = ListeAmis()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.donnee.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellule", forIndexPath: indexPath) as! MesAmisCell

        let entre = data.donnee[indexPath.row]
        
        cell.titleCell.setTitle(entre.pseudo, forState: .Normal)

        return cell
    }
 

 }
