//
//  ForecastVC.swift
//  OpenWeather
//
//  Created by Pitchaorn on 18/5/2565 BE.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import Kingfisher

class ForecastVC: ForecastLayout {
    
    var city = ""
    
    var temp:Temperature = .Celsius
    
    let disposeBag = DisposeBag()
    
    private var viewModel = ForecastListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "ForecastTableViewCell")
        self.navigationItem.title = city
        viewModel.fetchForecastViewModels(city, temp)
            .catch { _ in Observable.never() }
            .trackActivity(viewModel.isLoading)
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "ForecastTableViewCell", cellType: ForecastTableViewCell.self)){
            index, viewModel, cell in
                let degree = self.temp == .Celsius ? "°C" : "°F"
                let url = URL(string: viewModel.weatherImg)
                cell.weatherImage.kf.setImage(with: url)
                cell.dateLabel.text = viewModel.dateTime
                cell.tempLabel.text = "Temperature : \(viewModel.temperature) \(degree)"
                cell.humidityLabel.text = "Humidity : \(viewModel.humidity)%"
        }.disposed(by: disposeBag)
        
        viewModel.isLoading
            .asObservable().bind(to: SVProgressHUD.rx.isAnimating).disposed(by: disposeBag)
        
    }
    

}
