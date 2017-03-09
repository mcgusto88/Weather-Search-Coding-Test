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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateTableView() {
        //self.weatherDict = (request?.weatherDict)!
        let weatherResults = request?.weatherResultsObect()
        if let temperature = weatherResults?.temperature{
            self.temperatureLbl.text = "Temperature: \(temperature)"
        }
        if let weather = weatherResults?.weather {
            self.weatherLbl.text = "Weather: \(weather)"
        }
        self.weatherImage.image = weatherResults?.weatherImage
    }
}
