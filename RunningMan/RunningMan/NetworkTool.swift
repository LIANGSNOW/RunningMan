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
    
    static let networkTool = NetworkTool()
    
    private init(){
        defaultConfigObject = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration : defaultConfigObject, delegate : nil, delegateQueue : NSOperationQueue.mainQueue())
    }
    
    func urlRequest(url : String) -> NSDictionary{
        
        let nsurl : NSURL = NSURL(string : url)!
        var resultDate : NSData = NSData()
        var jsonResult : NSDictionary = NSDictionary()
        
        session.dataTaskWithURL(nsurl, completionHandler: {(data, responnse ,error) in
            if (error != nil) {
                print("Error %@",error!.userInfo);
                print("Error description %@", error!.localizedDescription);
                print("Error domain %@", error!.domain);
            }
            // Process the data
            if (data != nil){
                print(data!.length)
                resultDate = data!
            } else {
                print("error")
            }
        }).resume()
        do{
            jsonResult = try NSJSONSerialization.JSONObjectWithData(resultDate, options: []) as! NSDictionary
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return jsonResult
    }
    
}