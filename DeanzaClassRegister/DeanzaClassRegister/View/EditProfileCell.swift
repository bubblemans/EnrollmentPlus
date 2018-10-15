//
//  EditProfileCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/13.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class EditProfileCell: UITableViewCell {
    var title: String?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
        setupTextField()
        
        
    }
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.textAlignment = .left
    }
    
    private func setupTextField() {
        self.addSubview(inputTextField)
        inputTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    override func setNeedsLayout() {
        if let title = title {
            titleLabel.text = title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







