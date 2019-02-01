//
//  SettingCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/11.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    var optionLabelText: String?
    var iconName: String?
    
    let optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        setupIcon()
        setupLabel()
        
    }
    
    private func setupIcon() {
        addSubview(iconView)
//        iconView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupLabel() {
        addSubview(optionLabel)
        optionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        optionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 20).isActive = true
        optionLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        optionLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    override func setNeedsLayout() {
        if let labelText = optionLabelText {
            optionLabel.text = labelText
        }
        
        if let iconName = iconName {
            iconView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
