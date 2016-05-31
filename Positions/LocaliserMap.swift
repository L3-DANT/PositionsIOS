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
    

    @IBOutlet weak var openMap: MKMapView!
    
    var locationManager: CLLocationManager!
    //var cl = CLLocationCoordinate2D(latitude: 48.8,longitude: 2.35)
    //let myLocation = CLLocation(latitude: 37, longitude: -122)
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

        /*
        let data = [Amis]()
        let totale = data.count-1
        print(totale)
        for index in 0...totale{
            let pos = data[index]
            let pin = PositionsAmis(cll: pos.position, nom: pos.pseudo)
            openMap.addAnnotation(pin)
        }*/
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
        //let url = "http://92.170.201.10/Positions/localisation/updateLoc"
        
        
        let url = "http://134.157.121.10:8080/Positions/localisation/updateLoc"
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


