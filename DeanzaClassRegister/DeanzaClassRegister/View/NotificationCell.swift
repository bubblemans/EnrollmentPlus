//
//  NotificationCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/28.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class NotificationCell: UICollectionViewCell {
    
    var title = String()
    var time = String()
    var detail = String()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupImageView()
        setupTitleLabel()
        setupTimeLabel()
        setupDetailLabel()
    }
    
    private func setupDetailLabel() {
        addSubview(detailLabel)
        detailLabel.frame = CGRect(x: 105, y: 50, width: 265, height: 30)
        detailLabel.text = "This is detail here......"
    }
    
    private func setupTimeLabel() {
        addSubview(timeLabel)
        timeLabel.frame = CGRect(x: 295, y: 10, width: 75, height: 30)
        timeLabel.text = "11:24 PM"
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 105, y: 10, width: 180, height: 30)
        titleLabel.text = "This is title here..."
        
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive =  true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








