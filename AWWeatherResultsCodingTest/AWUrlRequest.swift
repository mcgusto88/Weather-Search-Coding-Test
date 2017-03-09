//
//  AWUrlRequest.swift
//  AWCodingAssessmentBBVA
//
//  Created by Augustus on 2/25/17.
//  Copyright © 2017 Augustus. All rights reserved.
//

import UIKit
protocol UpdateTableViewProtocol {
    func updateUserInterface()
}
//Class used to make URL request and Parse JSON data
class AWUrlRequest: NSObject {
    
    var weatherDict = Dictionary<String,Any>()
    var url:String?
    var imageUrl:String? = "http://openweathermap.org/img/w/"
    var delegate:UpdateTableViewProtocol! = nil
    var weatherResult = AWWeatherResults()

    
    convenience init(url:String){
        self.init()
        self.url = url
        self.weatherDict = Dictionary()
        
    }
    func getWeatherResults(urlString:String!){
        let theUrl = URL(string:(urlString?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)!

        //Used to make URL Request
        let task = URLSession.shared.dataTask(with: theUrl as URL) { (data, response, error) -> Void in
            print("Task completed")
            if let data = data {
                do {
                    //Used to Parse JSON
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let jsonObj = jsonResult["weather"] as? NSArray{
                            let weatherDict = jsonObj.firstObject as! NSDictionary
                            print(weatherDict["main"]!)
                            self.weatherDict["weather"] = weatherDict["main"] as? String
                            if let tempWeatherDict = weatherDict["icon"] {
                                self.weatherDict["icon"] = tempWeatherDict as? String
                                
                                //Get Image back from URL
                                self.getImage(imageIcon:self.weatherDict["icon"] as! String)
                            }
                        }
                        if let jsonObj = jsonResult["main"] as? NSDictionary{
                            if let temp = jsonObj["temp"]{
                            self.weatherDict["temp"] = String(describing: temp)
                                print(temp)
                            let tempDict = AWWeatherResults.init(self.weatherDict )
                                self.weatherResult = tempDict

                            }
                        }
                        //Delegat Method used to Update UI
                        DispatchQueue.main.async {
                            self.delegate.updateUserInterface()
                        }

                       
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    //Funtion used to convert Data from URL to UIImage
    func getImage(imageIcon:String)
    {
        
        let url = NSURL(string:self.imageUrl! + imageIcon + Constants.PNG)
        let data = try? Data(contentsOf: url! as URL)
        self.weatherDict["image"] = UIImage(data: data!)
        print(data!)
    }
    
    func weatherResultsObect()-> AWWeatherResults{
        return self.weatherResult
    }

    
}
