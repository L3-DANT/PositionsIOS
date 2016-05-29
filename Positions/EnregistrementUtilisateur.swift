
import Foundation


class EnregistrementUtilisateur{
    
    
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
                
            })
            task.resume()
        }
}
