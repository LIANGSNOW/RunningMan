//
//  ImageBase64Tool.swift
//  RunningMan
//
//  Created by zz on 5/11/16.
//  Copyright © 2016 Group16. All rights reserved.
//

import Foundation
import UIKit

class ImageBase64Tool{
    class func convertImageToBase64(image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
        return base64String
        
    }
    
    class func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0) )
        
        let decodedimage = UIImage(data: decodedData!)
        
        return decodedimage!
        
    }
}