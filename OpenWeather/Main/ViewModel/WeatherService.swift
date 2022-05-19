//
//  WeatherService.swift
//  OpenWeather
//
//  Created by Pitchaorn on 17/5/2565 BE.
//

import Foundation
import RxSwift
import Alamofire

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}

enum Temperature:String{
    case Celsius = "metric"
    case Fahrenheit = "imperial"
}

protocol WeatherServiceProtocol{
    func fetchWeather(_ city:String,_ temp:Temperature) -> Observable<WeatherModel>
}

class WeatherService: WeatherServiceProtocol{
    func fetchWeather(_ city: String, _ temp: Temperature) -> Observable<WeatherModel> {
        return Observable.create { observer -> Disposable in
            let request = AF.request("\(GlobalConstant.url)weather?q=\(city)&appid=\(GlobalConstant.apiKey)&units=\(temp.rawValue)")
            
            request.responseData { (response) in
                switch response.result{
                case .success(let data):
                    //Everything is fine, return the value in onNext
                    do {
                        let decoder = JSONDecoder()
                        let weatherRequest = try decoder.decode(WeatherModel.self, from: data)
                        observer.onNext(weatherRequest)
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
