//
//  AWWeatherResults.swift
//  AWCodingAssessmentBBVA
//
//  Created by Augustus on 3/8/17.
//  Copyright © 2017 Augustus. All rights reserved.
//

import UIKit
//Model Class use for consuming JSON 
//and also Conforms to NSCoding for Archiving Class Objects

class AWWeatherResults: NSObject, NSCoding {
    var weather:String?
    var temperature:String?
    var weatherImage:UIImage?
    var city:String?
    
    
    convenience init(_ dictionary: Dictionary<String, Any>) {
        self.init()
        self.weather = dictionary["weather"]  as! String? ?? "Weather Not Found"
        self.temperature = dictionary["temp"]  as! String? ?? "temperature not found"
        self.city = String()
        if let weatherImage = dictionary["image"] as? UIImage{
            self.weatherImage = weatherImage
        }
        
    }
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
         weather = aDecoder.decodeObject(forKey: Constants.WEATHER) as! String?
        temperature = aDecoder.decodeObject(forKey: Constants.TEMPERATURE) as? String
        weatherImage = aDecoder.decodeObject(forKey: Constants.WEATHERIMAGE) as? UIImage
        city = aDecoder.decodeObject(forKey:Constants.CITY) as? String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(weather, forKey: Constants.WEATHER)
        aCoder.encode(temperature, forKey:Constants.TEMPERATURE)
        aCoder.encode(weatherImage, forKey:Constants.WEATHERIMAGE)
        aCoder.encode(city,forKey:Constants.CITY)
    }
}

