//
//  ForecastTableViewCell.swift
//  OpenWeather
//
//  Created by Pitchaorn on 18/5/2565 BE.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    lazy var cellView: UIView = {
        [unowned self] in
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    lazy var weatherImage: UIImageView = {
        [unowned self] in
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    
    lazy var dateLabel : UILabel = {
        [unowned self] in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var tempLabel : UILabel = {
        [unowned self] in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var humidityLabel : UILabel = {
        [unowned self] in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(cellView)
        contentView.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: cellView)
        contentView.addConstraintsWithFormat("V:|-10-[v0]-10-|", views: cellView)
        
        _ = [weatherImage,dateLabel,tempLabel,humidityLabel].compactMap{
            cellView.addSubview($0)
        }
        
        cellView.addConstraintsWithFormat("V:|-10-[v0(70)]-10-|", views: weatherImage)
        cellView.addConstraintsWithFormat("H:|-10-[v0(70)]-10-[v1]-10-|", views: weatherImage,dateLabel)
        cellView.addConstraintsWithFormat("H:|-10-[v0(70)]-10-[v1]-10-|", views: weatherImage,tempLabel)
        cellView.addConstraintsWithFormat("H:|-10-[v0(70)]-10-[v1]-10-|", views: weatherImage,humidityLabel)
        cellView.addConstraintsWithFormat("V:|-10-[v0]-10-[v1(==v0)]-10-[v2(==v0)]-10-|", views: dateLabel,tempLabel,humidityLabel)
        
    }

}
