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
    
    static let networkTool = NetworkTool()
    
    private init(){
        defaultConfigObject = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration : defaultConfigObject, delegate : nil, delegateQueue : NSOperationQueue.mainQueue())
    }
    
    func urlRequest(url : String, method : String = "GET") -> NSString{
        
        let nsurl : NSURL = NSURL(string : url)!
        let request = NSMutableURLRequest(URL: nsurl)
        request.HTTPMethod = method
        session.dataTaskWithRequest(request){
            data, response, error in
            self.responseString = NSString(data: data!, encoding:  NSUTF8StringEncoding)!
            print(self.responseString)
        }.resume()
        return self.responseString
    }
    
}