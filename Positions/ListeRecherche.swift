//
//  ListeRecherche.swift
//  Positions
//
//  Created by cai xue on 30/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation
import UIKit

class ListeRecherche : UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource{
    
    @IBOutlet weak var barreRecherche: UISearchBar!
    @IBOutlet var table: UITableView!
    
  
    
    var searchActive : Bool = false
    var dataTable:[String] = []
    var filtered:[String] = []
    var test = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //barreRecherche.showsScopeBar = true
        table.delegate = self
        barreRecherche.delegate = self
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    func searchBar(barreRecherche: UISearchBar, textDidChange searchText: String)
    {
        
        //"http://92.170.201.10/Positions/utilisateur/recherche"
        //http://134.157.122.100:8080/Positions/utilisateur/recherche
        let request = NSMutableURLRequest(URL: NSURL(string: "http://92.170.201.10/Positions/utilisateur/recherche?prefix="+searchText)!)
        
            Recherche.findAsynchronously(request){data in
                print("Asynchronously fetched \(data!.length) bytes")
                //self.dataTable = []
                var pseudo = ""
                var token = ""
                
                do{
                    if let listUser = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray{
                        self.dataTable.removeAll()
                        print(listUser.count)
                        for(var i = 0; i<listUser.count; i++){
                            self.dataTable.append(listUser[i] as! String)
                        }
                        print(self.dataTable)
                        //self.dataTable = listUser as! [String]
                        /*pseudo = (user["pseudo"] as? String)!
                        token = (user["token"] as? String)!*/
                        self.table.reloadData()
                    }
                    
                } catch let error as NSError{
                    print(error)
                }
                
                print("token after inscription : " + token)
 
            }
        
        filtered = dataTable.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.table.reloadData()
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return dataTable.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! ListeRechercheCell;
        if(searchActive){
            cell.userName.text = filtered[indexPath.row]
        } else {
            cell.userName?.text = dataTable[indexPath.row]
        }
        
        return cell;
    }
    
}
 
 