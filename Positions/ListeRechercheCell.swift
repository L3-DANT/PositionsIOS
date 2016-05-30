//
//  ListeRechercheCell.swift
//  Positions
//
//  Created by cai xue on 30/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import UIKit

class ListeRechercheCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    
    @IBAction func addInvitation(sender: AnyObject) {
        print(userName.text)
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
