
import Foundation


class EnregistrementUtilisateur{
    
    /*static func enregistrement(motPasse:String,motPasse1:String,mail:String, pseudo:String) -> Bool {
        
        var retour:Bool
        
        retour = false 
        
        let url = "http://92.170.201.10/Positions/utilisateur/inscription"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        //let semaphore = dispatch_semaphore_create(0)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["pseudo":pseudo, "motDePasse":motPasse, "mail":mail] as Dictionary<String, String>
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            print(error)
        }*/
        
        static func getDataAsynchronously(request: NSMutableURLRequest, motPasse:String, mail:String, pseudo:String, completion: NSData? -> ()){
            request.HTTPMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let params = ["pseudo":pseudo, "motDePasse":motPasse, "mail":mail] as Dictionary<String, String>
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            } catch {
                print(error)
            }
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                
                completion(data)
                /*guard data != nil else {
                    // print("no data found: \(error)")
                    return
                }
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                    print("Utilisateur ajouté dans la base")
                    print(json)
                    //retour = true
                    //dispatch_semaphore_signal(semaphore) //on rend la requête synchrone
                //sauvegarder token et pseudo ici
                
                
                
                } catch let parseError {
                    print("Utilisateur déjà existant")
                    print(parseError)
                
                }*/
            })
            task.resume()
        }
        //dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
       /* print(retour)
        return retour
    
    
    }*/
}
