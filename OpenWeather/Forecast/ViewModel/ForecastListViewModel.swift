//
//  ForecastListViewModel.swift
//  OpenWeather
//
//  Created by Pitchaorn on 18/5/2565 BE.
//

import Foundation
import RxSwift

final class ForecastListViewModel {
    
    private let forecastService: ForecastServiceProtocol
    
    let isLoading = ActivityIndicator()
    
    init(forecastService: ForecastServiceProtocol = ForecastService()) {
        self.forecastService = forecastService
    }
    
    func fetchForecastViewModels(_ city: String, _ temp: Temperature) -> Observable<[ForecastViewModel]>{
        forecastService.fetchForecast(city, temp).map{
            $0.list.map{
                $0.map{
                    ForecastViewModel(forecastList: $0)
                }
            } as! [ForecastViewModel]
        }
    }
    
    
    
    
}
