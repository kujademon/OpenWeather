//
//  ForecastViewModel.swift
//  OpenWeather
//
//  Created by Pitchaorn on 18/5/2565 BE.
//

import Foundation

struct ForecastViewModel {
    
    private let forecastList: ListForecast
    
    var dateTime: String {
        return forecastList.dtTxt ?? ""
    }
    
    var temperature: String {
        return "\(forecastList.main?.temp ?? 0)"
    }
    
    var humidity: String {
        return "\(forecastList.main?.humidity ?? 0)"
    }
    
    var weatherImg: String {
        return "http://openweathermap.org/img/wn/\(forecastList.weather?.first?.icon ?? "")@2x.png"
    }
    
    init(forecastList: ListForecast){
        self.forecastList = forecastList
    }
    
}
