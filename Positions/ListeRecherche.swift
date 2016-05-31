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
        //"http://92.170.201.10/Positions/utilisateur/recherche?prefix="+searchText
        //let url = "http://134.157.121.10:8080/Positions/utilisateur/recherche?prefix="+searchText
        let request = NSMutableURLRequest(URL: NSURL(string: "http://92.170.201.10/Positions/utilisateur/recherche?prefix="+searchText)!)
        
            Recherche.findAsynchronously(request){data in
                print("Asynchronously fetched \(data!.length) bytes")
                //self.dataTable = []
                do{
                   if let listUser = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray{
                    
                        self.dataTable.removeAll()
                        print(listUser.count)
                    if listUser.count > 0{
                        for i in 0...listUser.count-1{
                            self.dataTable.append(listUser[i] as! String)
                        }
                    }
                        print(self.dataTable)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.table.reloadData()
                        })
                    }
                } catch let error as NSError{
                        print(error)
                }
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
        //print(self.dataTable)

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
 
 