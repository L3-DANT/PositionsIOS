//
//  LocaliserMap.swift
//  Positions
//
//  Created by cai xue on 09/05/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

//
//  Localisation.swift
//  Positions
//
//  Created by cai xue on 07/04/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation


import MapKit




class LocaliserMap: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    var liste = [Amis]()
    var statu:bool = true

    @IBOutlet weak var openMap: MKMapView!
    
    var locationManager: CLLocationManager!
    //var cl = CLLocationCoordinate2D(latitude: 48.8,longitude: 2.35)
    //let myLocation = CLLocation(latitude: 37, longitude: -122)
    
    
   
    
    
    override func viewDidLoad() {
        
        recupererListeAmis()
        super.viewDidLoad()
        
        
        /*print("ICI ")
        print(liste)
        let defaults = NSUserDefaults.standardUserDefaults()
        let decoded = defaults.objectForKey("friends") as! NSData
        var decodedAmis = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [Amis]
        //test = defaults.objectForKey("friends") as! NSArray as! [Amis]
        for element in decodedAmis {print(element)}

        */
        
        locationManager=CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//précision pour la localisation
        locationManager.requestAlwaysAuthorization()//demande l'autorisation de localisation
        locationManager.startUpdatingLocation()//start
        openMap.showsUserLocation = true//affiche mon point
        
        
        /*
        var timer = NSTimer()
        let delay = 5000.0
        
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: #selector(LocaliserMap.locationManager), userInfo: nil, repeats: true)
        timer.invalidate()
        */

    
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func recupererListeAmis(){
        
        //let url = "http://134.157.24.6:8080/Positions/invitation/recupInvits"
        var url = ""
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let pseudo = defaults.stringForKey("pseudo"){
            //url = "http://134.157.121.10:8080/Positions/utilisateur/getFriends?pseudo=" + pseudo
            url = "http://92.170.201.10/Positions/utilisateur/getFriends?pseudo=" + pseudo
        }
        print(url)
        //let url = "http://134.157.122.100:8080/Positions/utilisateur/connexion"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        AmisService.send(request){data in
            print("Asynchronously fetched \(data!.length) bytes")
            
            do{
                if let listeAmis = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSArray{
                    print(listeAmis.count)
                    if listeAmis.count > 0{
                    for i in 0...listeAmis.count-1{
                        let pseudo = listeAmis[i]["pseudo"] as! String
                        let longitude = listeAmis[i]["loc"]!!["longitude"] as! Float
                        let latitude = listeAmis[i]["loc"]!!["latitude"] as! Float
                        let date = listeAmis[i]["loc"]!!["date"] as! String
                        let heure = listeAmis[i]["loc"]!!["heure"] as! String
                        let local = Localisation(longitude: longitude,latitude: latitude,heure: heure,date: date)
                        let amis = Amis(pseudo: pseudo,position: local)
                        print(pseudo + ":" + String(local.latitude) + ";" + String(local.longitude))
                        print(amis)
                        self.liste.append(amis)
                        }
                    }
                    
                    
                    
                    //print(data[i].demandeur + " " + data[i].concerne + " " + data[i].accept + " " + data[i].date )
                    print(self.liste)
                    dispatch_async(dispatch_get_main_queue(), {
                        let defaults = NSUserDefaults.standardUserDefaults()
                        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(self.liste)
                        defaults.setObject(encodedData, forKey: "friends")
                        defaults.synchronize()
                    })
                }
                
            }catch let error as NSError{
                print(error)
            }
            
            
        }
        //print(self.data[0])
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        /*print(latitude)
        print(longitude)
        */
        let seconds = 5.0
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            //print("send location")
            self.envoiLocation(latitude!,lo:longitude!)
        })
        
        let totale = liste.count-1
        if totale > 0{
            for index in 0...totale{
                let pos = liste[index]
                let local = CLLocationCoordinate2D(latitude: Double(pos.position.latitude), longitude: Double(pos.position.longitude))
                print(pos.pseudo + ":" + String(local.longitude) + ";" +  String(local.latitude))
                let pin = PositionsAmis(cll: local, nom: pos.pseudo)
                openMap.addAnnotation(pin)
            }
        }
        
        /*let width = 1000.0
        let height = 1000.0
        let center = CLLocationCoordinate2D(latitude:latitude!, longitude:longitude!)
        let region = MKCoordinateRegionMakeWithDistance(center, width, height)
        openMap.setRegion(region, animated: true)*/
        
        //        let date = NSDate()
        //
        //        print(date)
    }
    
    
    
    
    
    func envoiLocation(la:Double, lo:Double){
        let url = "http://92.170.201.10/Positions/localisation/updateLoc"
        
        
        //let url = "http://134.157.121.10:8080/Positions/localisation/updateLoc"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        let componentsHour = calendar.components([.Hour, .Minute], fromDate: date)
        
        
        let hour = componentsHour.hour
        let minutes = componentsHour.minute
        
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        let stringDate = String(day)  + "/" + String(month) + "/" + String(year)
        let stringHour = String(hour) + "/" + String(minutes)
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let pseudo = defaults.stringForKey("pseudo"){
            let params = ["pseudo": pseudo, "loc": ["latitude":la , "longitude":lo, "heure":stringHour, "date":stringDate] ] as Dictionary<String, AnyObject>
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            } catch {
                print(error)
            }
            
            let task = session.dataTaskWithRequest(request) { data, response, error in
                guard data != nil else {
                    print("no data found: \(error)")
                    return
                }
                
            }
            task.resume()
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
}


