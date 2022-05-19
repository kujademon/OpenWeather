//
//  ForecastLayout.swift
//  OpenWeather
//
//  Created by Pitchaorn on 18/5/2565 BE.
//

import UIKit

class ForecastLayout: UIViewController {

    lazy var tableView: UITableView = {
        [unowned self] in
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.bounces = false
        table.rowHeight = UITableView.automaticDimension
        table.alwaysBounceVertical = false
        table.contentInsetAdjustmentBehavior = .automatic
        table.tableFooterView = UIView()
        table.separatorColor = .white
        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        table.backgroundColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
        table.allowsSelection = false
        return table
        }()
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addConstraintsWithFormat("H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat("V:|[v0]|", views: tableView)
    }

}
