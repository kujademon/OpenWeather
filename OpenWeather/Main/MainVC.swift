//
//  MainVC.swift
//  OpenWeather
//
//  Created by Pitchaorn on 17/5/2565 BE.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import SVProgressHUD

class MainVC: MainLayout {
    
    let disposeBag = DisposeBag()
    
    private var viewModel = WeatherListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
        
        let cityValid = cityTextField
            .rx.text
            .orEmpty
            .map { !$0.isEmpty }
            
        cityValid.bind(to: searchBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        cityValid.bind(to: tempSegmentedControl.rx.isEnabled)
            .disposed(by: disposeBag)
        
        cityValid.bind(to: forecastButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        searchBtn.rx.tap
              .subscribe(onNext: { _ in
                  self.fetchWeather()
                  self.view.endEditing(true)
              })
             .disposed(by: disposeBag)
        
        tempSegmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: {_ in
                self.fetchWeather()
            })
            .disposed(by: disposeBag)
        
        forecastButton.rx.tap
            .subscribe(onNext: {
                
                let vc = ForecastVC()
                vc.city = self.cityTextField.text ?? ""
                vc.temp = self.tempSegmentedControl.selectedSegmentIndex == 0 ? .Celsius : .Fahrenheit
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .asObservable().bind(to: SVProgressHUD.rx.isAnimating).disposed(by: disposeBag)
    }

    
    func fetchWeather(){
        let city = cityTextField.text ?? ""
        let temp:Temperature = tempSegmentedControl.selectedSegmentIndex == 0 ? .Celsius : .Fahrenheit
        viewModel.fetchWeatherViewModels(city, temp)
            .observe(on: MainScheduler.instance)
            .trackActivity(viewModel.isLoading)
            .subscribe(onNext:{ weather in
                let degree = temp == .Celsius ? "°C" : "°F"
                let url = URL(string: weather.weatherImg)
                self.weatherImage.kf.setImage(with: url)
                self.tempLabel.text = "Temperature : \(weather.temperature) \(degree)"
                self.humidityLabel.text = "Humidity : \(weather.humidity)%"
            },onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    
}
