//
//  PreferenceView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/11.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class PreferenceView: UIView, UITableViewDataSource, UITableViewDelegate {
    let cellId = "cellId"
    var baseController: SettingViewController?
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PREFERENCES"
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingCell
        cell.optionLabelText = preferenceOption[indexPath.row]
        cell.iconName = prefIcon[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return preferenceOption.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let destination = EditProfileController()
            baseController?.present(destination, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            let destination = ChangePhotoViewController()
            baseController?.navigationController?.pushViewController(destination, animated: true)
        } else if indexPath.row == 2 {
            
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        
        let count = preferenceOption.count
        self.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 44).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: CGFloat(44 * count)).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellId)
        
        tableView.isScrollEnabled = false
    }
    
    private func setupLabel() {
        self.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
}
