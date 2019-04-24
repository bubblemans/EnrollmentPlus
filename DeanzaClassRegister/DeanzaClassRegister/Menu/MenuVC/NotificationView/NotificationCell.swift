//
//  NotificationCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/28.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class NotificationCell: UICollectionViewCell {
    
//    var title = String()
    var time = String()
    var detail = String()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        return view
    }()
    
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        return label
//    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupImageView()
//        setupNameLabel()
        setupTimeLabel()
        setupDetailLabel()
    }
    
    public func setupView() {
        setupImageView()
//        setupNameLabel()
        setupTimeLabel()
        setupDetailLabel()
    }
    
    private func setupDetailLabel() {
        addSubview(detailLabel)
        detailLabel.frame = CGRect(x: 105, y: 30, width: 300, height: 60)
        detailLabel.text = detail
        detailLabel.numberOfLines = 0
    }
    
    private func setupTimeLabel() {
        addSubview(timeLabel)
        timeLabel.frame = CGRect(x: 105, y: 10, width: 200, height: 30)
        timeLabel.text = time.replacingOccurrences(of: "T", with: " ")
        timeLabel.text = timeLabel.text?.replacingOccurrences(of: ".000Z", with: "")
    }
    
//    private func setupNameLabel() {
//        addSubview(nameLabel)
//        nameLabel.frame = CGRect(x: 105, y: 10, width: 130, height: 30)
////        nameLabel.text = "This is title here..."
//        nameLabel.text = title
//
//    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.frame = CGRect(x: 10, y: 15, width: 75, height: 75)
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








