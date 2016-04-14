//
//  Localisation.swift
//  Positions
//
//  Created by cai xue on 07/04/2016.
//  Copyright © 2016 m2sar. All rights reserved.
//

import Foundation


import MapKit



class Localisation: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
  
    @IBOutlet weak var openMap: MKMapView!
    
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager=CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        openMap.showsUserLocation = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
         print("didReceive")
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("hellllooooo")
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
        
    }
    
   /* func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
         print("mapView")
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        print(latitude)
        print(longitude)
        
        let center = CLLocationCoordinate2D(latitude:latitude ,longitude:longitude)
     
        
        let width = 1000.0
        let height = 1000.0
        let region = MKCoordinateRegionMakeWithDistance(center, width, height)
        mapView.setRegion(region, animated: true)
        
        self.envoi(latitude,lo:longitude)
        
    }*/
    
    
    func envoi(la:Double, lo:Double){
        
        print("helpppppppppppp")
        let url = "http://132.227.125.142:8080/Positions/utilisateur/testLoc"
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


