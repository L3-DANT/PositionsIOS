//
//  MesAmis.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class MesInvitations: UITableViewController {
    
    var liste = [Invitation]()
    
    
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        recupererListeInvitation()
        super.viewDidLoad()
        

        tabBarController?.tabBar.items?[1].badgeValue = String(conteur)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MesInvitations.loadList(_:)),name:"supInvitation", object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MesInvitations.loadListRefu(_:)),name:"supInvitationRefu", object:nil)
    
    }
    
    func loadList(notification: NSNotification){
        //load data here
        let invita = notification.object as! Invitation
        print("demandeur: " + invita.demandeur)
        print("concerne: " + invita.concerne)
        
        let accepteAlert = UIAlertController(title: "Annonce", message:
            "L'invitation est acceptée !", preferredStyle: UIAlertControllerStyle.Alert)
        accepteAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(accepteAlert, animated: true, completion: nil)
        

        if liste.count > 0 {
        for i in 0...liste.count-1{
            if liste[i].demandeur == invita.demandeur && liste[i].concerne == invita.concerne{
                liste.removeAtIndex(i)
            }
        }
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.table.reloadData()
        })
    }
    
    func loadListRefu(notification: NSNotification){
        //load data here
        let invita = notification.object as! Invitation
        print("demandeur: " + invita.demandeur)
        print("concerne: " + invita.concerne)
        
        let refuAlert = UIAlertController(title: "Annonce", message:
            "L'invitation est refusée !", preferredStyle: UIAlertControllerStyle.Alert)
        refuAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(refuAlert, animated: true, completion: nil)
        
        
        if liste.count > 0 {
            for i in 0...liste.count-1{
                if liste[i].demandeur == invita.demandeur && liste[i].concerne == invita.concerne{
                    liste.removeAtIndex(i)
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.table.reloadData()
        })
    }

    
    var conteur = 0
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return liste.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellule", forIndexPath: indexPath) as! MesInvitationsCell
        
        let entre = liste[indexPath.row]
        print(entre.concerne + ": " + entre.date)
        let defaults = NSUserDefaults.standardUserDefaults()
        if let pseudo = defaults.stringForKey("pseudo"){
            if entre.demandeur != pseudo{
                cell.nomCell.text = entre.demandeur
                cell.dateCell.text = entre.date
                
            }
        }
        
        
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
                    if answer.count > 0{
                    for i in 0...answer.count-1{
                        let demandeur = answer[i]["demandeur"] as! String
                        let concerne = answer[i]["concerne"] as! String
                        let date = answer[i]["date"] as! String
                        let accept = answer[i]["accept"] as! String
                        let invit = Invitation(demandeur: demandeur, concerne: concerne, date: date, accept: accept)
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            let defaults = NSUserDefaults.standardUserDefaults()
                            if let pseudo = defaults.stringForKey("pseudo"){
                                if demandeur != pseudo{
                                    self.liste.append(invit as Invitation!)
                                    self.conteur = self.conteur + 1
                                    print("Affffffiche : ", self.conteur)
                                    self.tabBarController?.tabBar.items?[1].badgeValue = String(self.conteur)
                                }
                            }
                            
                            
                        })
                        }
                        //print(data[i].demandeur + " " + data[i].concerne + " " + data[i].accept + " " + data[i].date )
                    }
                    
                    print(self.liste)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.table.reloadData()
                    })
                }
               
            } catch let error as NSError{
                print(error)
            }
            
           

        }
        
        //print(self.data[0])
    }
}
