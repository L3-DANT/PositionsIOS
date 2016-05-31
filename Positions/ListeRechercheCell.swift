//
//  ListeRechercheCell.swift
//  Positions
//
//  Created by cai xue on 30/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class ListeRechercheCell: UITableViewCell{

    @IBOutlet weak var userName: UILabel!
    
    
    @IBAction func addInvitation(sender: AnyObject) {
        print(userName.text)
        let defaults = NSUserDefaults.standardUserDefaults()
        var url = ""
        if let pseudo = defaults.stringForKey("pseudo"){
            url = "http://92.170.201.10/Positions/invitation/inviteFriend?demandeur=" + pseudo + "&concerne=" + userName.text!
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
            
            if(data!.length == 0){
                /*let errorAlert = UIAlertController(title: "Invitation", message:
                    "Cette invitation existe déjà!", preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Retour", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(errorAlert, animated: true, completion: nil)*/
                print("cette invitation existe deja")
            }
            else{
                print("invitation ajoutée!")
            }
        
        }
        //navigationController?.popViewControllerAnimated(true)
        //http://stackoverflow.com/questions/28760541/programmatically-go-back-to-previous-viewcontroller-in-swift
        
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
