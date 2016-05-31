//
//  MesInvitationsCell.swift
//  Positions
//
//  Created by cai xue on 14/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class MesInvitationsCell: UITableViewCell {

    @IBOutlet weak var nomCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    
    
    @IBAction func accept(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var url = ""
        if let pseudo = defaults.stringForKey("pseudo"){
            //url = "http://134.157.121.10:8080/Positions/invitation/decision?b=true&demandeur=" + pseudo + "&concerne="
            url = "http://92.170.201.10/Positions/invitation/decision?b=true&demandeur=" + pseudo + "&concerne="
        }
        print(url)
        //let url = "http://134.157.122.100:8080/Positions/utilisateur/connexion"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        InvitationService.send(request){data in
            print("Asynchronously fetched \(data!.length) bytes")
            
            do{
                if let answer = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                    print(answer)
                }
                
            } catch let error as NSError{
                print(error)
            }
            
        }
        
    }
    @IBAction func deny(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var url = ""
        if let pseudo = defaults.stringForKey("pseudo"){
            url = "http://92.170.201.10/Positions/invitation/decision?b=false&demandeur=" + pseudo + "&concerne="
        }
        print(url)
        //let url = "http://134.157.122.100:8080/Positions/utilisateur/connexion"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        InvitationService.send(request){data in
            print("Asynchronously fetched \(data!.length) bytes")
            
            do{
                if let answer = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                    print(answer)
                }
                
            } catch let error as NSError{
                print(error)
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
