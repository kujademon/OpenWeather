//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Pitchaorn on 17/5/2565 BE.
//

import Foundation

struct WeatherViewModel {
    
    private let weather: WeatherModel
    
    var temperature: String {
        return "\(weather.main?.temp ?? 0)"
    }
    
    var humidity: String {
        return "\(weather.main?.humidity ?? 0)"
    }
    
    var weatherImg: String {
        return "http://openweathermap.org/img/wn/\(weather.weather?.first?.icon ?? "")@2x.png"
    }
    
    init(weather: WeatherModel){
        self.weather = weather
    }
    
}
