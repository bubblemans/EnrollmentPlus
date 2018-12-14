//
//  CalendarCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/11/22.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    private func setupLabel() {
        self.addSubview(timeLabel)
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        timeLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        timeLabel.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







