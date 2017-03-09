//
//  ViewController.swift
//  weatherApp
//
//  Created by stagiaire on 09/03/2017.
//  Copyright © 2017 haoua. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let LocationManager = CLLocationManager()

    @IBOutlet weak var tempText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("magie")
        
        self.LocationManager.delegate = self
        self.LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.LocationManager.requestWhenInUseAuthorization()
        self.LocationManager.startUpdatingLocation()
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=Villeurbanne&appid=91b254a2e825b2cda95cdeeff959e009").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                let rsp = JSON as! NSDictionary
                print("bonjour")
                let main = rsp["main"] as! NSDictionary
                let temp = main["temp"]-2 
                self.tempText.text = "\(temp ?? "")"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil{
                print("Error")
            }
            
            if let pm = placemarks?.first{
                self.displayLocationInfo(placemark: pm)
            }
            else{
                print("Error : erreur data")
            }
        })
    }
    
    func displayLocationInfo(placemark:CLPlacemark){
        self.LocationManager.stopUpdatingLocation()
        // print(placemark.subThoroughfare)
//        print(placemark.thoroughfare)
//        print(placemark.locality)
//        print(placemark.postalCode)
//        print(placemark.subAdministrativeArea)
//        print(placemark.administrativeArea)
//        print(placemark.country)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : "+error.localizedDescription)
    }


}

