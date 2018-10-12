//
//  NotifactionView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/12.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class NotificationView: UIView, UITableViewDelegate, UITableViewDataSource {
    let cellId = "cellId"
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NOTIFICATION"
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingCell
        cell.iconName = notiIcon[indexPath.row]
        cell.optionLabelText = notiOption[indexPath.row]
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        setupLabel()
    }
    
    private func setupTableView() {
        let count = CGFloat(notiOption.count)
        self.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 44).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: count * 44).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupLabel() {
        self.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










