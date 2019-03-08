//
//  PasswordTableViewCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/19.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class OldPasswordTableViewCell: UITableViewCell {
    let cellId = "cellId"
    var titleText: String?
    var placeHolder: String?
    
    let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setNeedsLayout() {
        titleLabel.text = titleText
        textField.placeholder = placeHolder
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        oldPassword = textField.text
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: cellId)
        selectionStyle = .none
        
        // setup titleLabel
        self.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isAccessibilityElement = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        // setup textField
        self.addSubview(textField)
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
