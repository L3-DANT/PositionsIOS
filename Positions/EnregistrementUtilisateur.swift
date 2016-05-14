
import Foundation


class EnregistrementUtilisateur{
    
    static func enregistrement(motPasse:String,motPasse1:String,mail:String, pseudo:String,verif:String) -> Bool {
        
        var retour:Bool
        
        retour = false 
        
        let url = "http://132.227.125.88:8080/Positions/utilisateur/inscription"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["pseudo":pseudo, "motDePasse":motPasse, "mail":mail] as Dictionary<String, String>
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            print(error)
        }
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                // print("no data found: \(error)")
                return
            }
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    //   let success = json["pseudo"] as? String
                    // print("Success: \(success)")
                    //print((json["localisation:date"] as? String))
                    // print(json)
                    //verif = ""
                    
                    
                    
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    //print("Error could not parse JSON: \(jsonStr)")
                    if (jsonStr == true){
                        // print(jsonStr)
                    }
                    
                    
                }
            } catch let parseError {
                print(parseError)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //print(jsonStr)
                
                if((jsonStr ?? false) != nil){
                    retour = false
                }
                
                
                if (jsonStr == true){
                    retour = true
                    //  print("Connexion reussie !");
                }
            }
        }
        task.resume()
        return retour
    }
    
    
}
