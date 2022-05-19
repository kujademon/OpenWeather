//
//  WeatherListViewModel.swift
//  OpenWeather
//
//  Created by Pitchaorn on 17/5/2565 BE.
//

import Foundation
import RxSwift

final class WeatherListViewModel {
    
    private let weatherService: WeatherServiceProtocol
    
    let isLoading = ActivityIndicator()
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func fetchWeatherViewModels(_ city: String, _ temp: Temperature) -> Observable<WeatherViewModel>{
        weatherService.fetchWeather(city, temp).map{
            WeatherViewModel(weather: $0)
        }
        
    }
    
}
