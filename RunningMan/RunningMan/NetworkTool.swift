//
//  NetworkTool.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import UIKit

class NetworkTool {
    
    var buffer : NSMutableData!
    var defaultConfigObject : NSURLSessionConfiguration
    var session : NSURLSession
    var responseString : NSString = ""
    
    static let serverIP = "192.168.0.16:8080"
    
    static let networkTool = NetworkTool()
    
    private init(){
        defaultConfigObject = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration : defaultConfigObject, delegate : nil, delegateQueue : NSOperationQueue.mainQueue())
    }
    
    func urlRequest(url : String, function : (String) -> (), method : String = "GET"){
        let urlStr = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let nsurl : NSURL = NSURL(string : urlStr!)!
        let request = NSMutableURLRequest(URL: nsurl)
        request.HTTPMethod = method
        session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            self.responseString = NSString(data: data!, encoding:  NSUTF8StringEncoding)!
            function(self.responseString as String)
        }.resume()
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
}