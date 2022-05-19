//
//  MainLayout.swift
//  OpenWeather
//
//  Created by Pitchaorn on 17/5/2565 BE.
//

import UIKit
import SwiftUI

class MainLayout: UIViewController {
    
    lazy var forecastButton: UIButton = {
        [unowned self] in
        let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named: "rain"), for: .normal)
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return btn
    }()
    
    lazy var weatherImage: UIImageView = {
        [unowned self] in
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
//        imageView.image = #imageLiteral(resourceName: "default-image")
        return imageView
    }()
    
    lazy var cityTextField : UITextField = {
        [unowned self] in
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholder = "Please fill City"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var searchBtn : UIButton = {
        [unowned self] in
        let btn = UIButton()
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setBorder()
        btn.setRadius(radius: 10)
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var tempLabel : UILabel = {
        [unowned self] in
        let label = UILabel()
//        label.text = "tempLabel"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var humidityLabel : UILabel = {
        [unowned self] in
        let label = UILabel()
//        label.text = "humidityLabel"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var tempSegmentedControl : UISegmentedControl = {
        [unowned self] in
        let segment = UISegmentedControl(items: ["Celsius","Fahrenheit"])
        segment.selectedSegmentIndex = 0
        
        //Change text color of UISegmentedControl
        segment.tintColor = UIColor.black
        
        //Change UISegmentedControl background colour
        segment.backgroundColor = UIColor.white
        return segment
    }()

    func setupView(){
        view.backgroundColor = .white
        let barbutton = UIBarButtonItem(customView: forecastButton)
        barbutton.customView?.translatesAutoresizingMaskIntoConstraints = false
        barbutton.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        barbutton.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.navigationItem.rightBarButtonItem = barbutton
        let height = UIScreen.main.bounds.height
        _ = [tempSegmentedControl,cityTextField,searchBtn,weatherImage,tempLabel,humidityLabel].compactMap{
            view.addSubview($0)
        }
        
        view.addConstraintsWithFormat("V:|-35-[v0(20)]-10-[v1(20)]-10-[v2(\(height * 0.3))]-10-[v3]-10-[v4]", views: tempSegmentedControl,cityTextField,weatherImage,tempLabel,humidityLabel)
        
        tempSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        tempSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        searchBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        searchBtn.centerYAnchor.constraint(equalTo: cityTextField.centerYAnchor).isActive = true
        
        view.addConstraintsWithFormat("H:|-20-[v0]-20-[v1(100)]-20-|", views: cityTextField,searchBtn)
        view.addConstraintsWithFormat("H:|-20-[v0]-20-|", views: weatherImage)
        view.addConstraintsWithFormat("H:|-20-[v0]-20-|", views: tempLabel)
        view.addConstraintsWithFormat("H:|-20-[v0]-20-|", views: humidityLabel)
        
        
    }


}

