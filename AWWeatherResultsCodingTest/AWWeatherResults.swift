//
//  AWWeatherResults.swift
//  AWCodingAssessmentBBVA
//
//  Created by Augustus on 3/8/17.
//  Copyright © 2017 Augustus. All rights reserved.
//

import UIKit

class AWWeatherResults: NSObject {
    var weather:String?
    var temperature:String?
    var weatherImage:UIImage?
    
    
    convenience init(_ dictionary: Dictionary<String, Any>) {
        self.init()
        self.weather = dictionary["weather"]  as! String? ?? "Weather Not Found"
        self.temperature = dictionary["temp"]  as! String? ?? "temperature not found"
        if let weatherImage = dictionary["image"] as? UIImage{
            self.weatherImage = weatherImage
        }
        
    }
}

