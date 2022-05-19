//
//  GlobalConstant.swift
//  OpenWeather
//
//  Created by Pitchaorn on 17/5/2565 BE.
//

import Foundation

class GlobalConstant{
    
    static let apiKey : String = {
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "Key", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys ,let apikey = dict["apikey"] as? String{
            
            return apikey
        }
        return ""
    }()
    
    static let url = "https://api.openweathermap.org/data/2.5/"
    
}
