//
//  MesAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class MesAmis: UITableViewController {
    
    var liste = [Amis]()

    @IBOutlet var Table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recupererListeAmis()
        
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
        return liste.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celAmis", forIndexPath: indexPath) as! MesAmisCell

        let entre = liste[indexPath.row]
        cell.nomAmis.text = entre.pseudo

        

        return cell
    }
    
    func recupererListeAmis(){
        
        //let url = "http://134.157.24.6:8080/Positions/invitation/recupInvits"
        var url = ""
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let pseudo = defaults.stringForKey("pseudo"){
            url = "http://134.157.121.10:8080/Positions/utilisateur/getFriends?pseudo=" + pseudo
            //url = "http://92.170.201.10/Positions/invitation/recupInvits?pseudo=" + pseudo
        }
        print(url)
        //let url = "http://134.157.122.100:8080/Positions/utilisateur/connexion"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        AmisService.send(request){data in
            print("Asynchronously fetched \(data!.length) bytes")
            
            do{
                if let listeAmis = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray{
                    
                    for i in 0...listeAmis.count-1{
                        let pseudo = listeAmis[i]["pseudo"] as! String
                        let longitude = listeAmis[i]["loc"]!!["longitude"] as! Float
                        let latitude = listeAmis[i]["loc"]!!["latitude"] as! Float
                        let date = listeAmis[i]["loc"]!!["date"] as! String
                        let heure = listeAmis[i]["loc"]!!["heure"] as! String
                        let local = Localisation(longitude: longitude,latitude: latitude,heure: heure,date: date)
                        let amis = Amis(pseudo: pseudo,position: local)
                        print(pseudo)
                        print(amis)
                        self.liste.append(amis)
                        
                    }
                    //print(data[i].demandeur + " " + data[i].concerne + " " + data[i].accept + " " + data[i].date )
                    print(self.liste)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.Table.reloadData()
                    })
                }
                
            }catch let error as NSError{
                print(error)
            }
            
            
        }
        //print(self.data[0])
        
        
    }
    
 

 }
