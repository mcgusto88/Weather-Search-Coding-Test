//
//  ViewController.swift
//
//
//
//  Copyright © 2017 Augustus. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UpdateTableViewProtocol,UITextFieldDelegate {
    
    
    @IBAction func searchBtn(_ sender: Any) {
        
        guard let text = searchTF.text, !text.isEmpty else {
           return
        }
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(self.searchTF.text)&APPID=\(Constants.APIKEY)"
        request?.url = urlString
        print("Button Clicked")
        request?.getWeatherResults(urlString: urlString)
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
    
    //Initialize Components and Retrieve Data From Local Storage
    func initializeComponents() {
        request = AWUrlRequest()
        request?.delegate = self
        self.searchTF.delegate = self
        self.loadLocalWeatherResult()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUserInterface() {

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
    
    //Used to check if there is a value stored locally to be retreived
    func userAlreadyExist(kUsernameKey: String) -> Bool {
        return UserDefaults.standard.object(forKey: Constants.WEATHERRESULTS) != nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    func loadLocalWeatherResult() {
        if(self.userAlreadyExist(kUsernameKey: Constants.WEATHERRESULTS)){
            let decoded = UserDefaults.standard.value(forKey:Constants.WEATHERRESULTS) as! Data
            let savedWeatherResult = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! AWWeatherResults
            self.weatherLbl.text = "Weather: \(savedWeatherResult.weather!)"
            self.temperatureLbl.text = "Temperature: \(savedWeatherResult.temperature!)"
            self.weatherImage.image = savedWeatherResult.weatherImage
            self.cityLbl.text = savedWeatherResult.city
        }
    }
}
