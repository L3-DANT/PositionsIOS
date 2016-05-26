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
        
        let data = ListeAmis()
        for index in 0...1 {
            let pos = data.donnee[index]
            let pin = PositionsAmis(cll: pos.position, nom: pos.pseudo)
            openMap.addAnnotation(pin)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        print(latitude)
        print(longitude)
        
        envoi(latitude!,lo:longitude!)
        
        let width = 1000.0
        let height = 1000.0
        let center = CLLocationCoordinate2D(latitude:latitude!, longitude:longitude!)
        let region = MKCoordinateRegionMakeWithDistance(center, width, height)
        openMap.setRegion(region, animated: true)
        
        //        let date = NSDate()
        //
        //        print(date)
    }
    
    
    
    
    
    func envoi(la:Double, lo:Double){
        
        let url = "http://134.157.245.93:8080/Positions/utilisateur/testLoc"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["latitude":la , "longitude":lo] as Dictionary<String, Double>
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
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let success = json["success"] as? Int
                    print("Success: \(success)")
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
}


