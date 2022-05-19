//
//  ForecastService.swift
//  OpenWeather
//
//  Created by Pitchaorn on 18/5/2565 BE.
//

import Foundation
import RxSwift
import Alamofire

protocol ForecastServiceProtocol{
    func fetchForecast(_ city:String,_ temp:Temperature) -> Observable<ForecastModel>
}

class ForecastService: ForecastServiceProtocol{
    
    func fetchForecast(_ city: String, _ temp: Temperature) -> Observable<ForecastModel> {
        return Observable.create { observer -> Disposable in
            let request = AF.request("\(GlobalConstant.url)forecast?q=\(city)&appid=\(GlobalConstant.apiKey)&units=\(temp.rawValue)")
            
            request.responseData { (response) in
                switch response.result{
                case .success(let data):
                    //Everything is fine, return the value in onNext
                    do {
                        let decoder = JSONDecoder()
                        let forecastRequest = try decoder.decode(ForecastModel.self, from: data)
                        observer.onNext(forecastRequest)
                    } catch let error {
                        print(error)
                        observer.onError(error)
                    }
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                    
                }
                
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
    
}
