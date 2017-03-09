//
//  ViewController.swift
//  AWCodingAssessmentBBVA
//
//  Created by Augustus on 2/25/17.
//  Copyright © 2017 Augustus. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UpdateTableViewProtocol {
    
    
    @IBAction func searchBtn(_ sender: Any) {
        
        guard let text = searchTF.text, !text.isEmpty else {
           return
        }
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(self.searchTF.text)&APPID=\(Constants.APIKEY)"
        request?.url = urlString
        print("Button Clicked")
        request?.getStateArray(urlString: urlString)
    }
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    var weatherDict:Dictionary<String,Any>?
    
    var request:AWUrlRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeComponents()
    }
    func initializeComponents() {
        request = AWUrlRequest()
        request?.delegate = self
        if(self.userAlreadyExist(kUsernameKey: Constants.WEATHERRESULTS)){
        let decoded = UserDefaults.standard.value(forKey:Constants.WEATHERRESULTS) as! Data
        let savedWeatherResult = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! AWWeatherResults
            self.weatherLbl.text = savedWeatherResult.weather
            self.temperatureLbl.text = savedWeatherResult.temperature
            self.weatherLbl.text = savedWeatherResult.weather
            self.weatherImage.image = savedWeatherResult.weatherImage
            self.cityLbl.text = savedWeatherResult.city
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateTableView() {
        //self.weatherDict = (request?.weatherDict)!
        let weatherResults = request?.weatherResultsObect()
        weatherResults?.city = self.searchTF.text
        if let temperature = weatherResults?.temperature{
            self.temperatureLbl.text = "Temperature: \(temperature)"
        }
        if let weather = weatherResults?.weather {
            self.weatherLbl.text = "Weather: \(weather)"
        }
        self.weatherImage.image = weatherResults?.weatherImage
        self.cityLbl.text = weatherResults?.city
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: weatherResults!)
        UserDefaults.standard.set(encodedData, forKey: Constants.WEATHERRESULTS)
        searchTF.text = ""

        

    }
    func userAlreadyExist(kUsernameKey: String) -> Bool {
        return UserDefaults.standard.object(forKey: Constants.WEATHERRESULTS) != nil
    }
}
