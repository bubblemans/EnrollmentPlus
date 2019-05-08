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
    var baseController: UIViewController?
    
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
    
    let blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let photoOptionsView: PhotoOptionTableView = {
        let view = PhotoOptionTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
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
//        if indexPath.row == 0 {
//            let destination = EditProfileController()
//            baseController?.present(destination, animated: true, completion: nil)
//        } else
        if indexPath.row == 0 {
            handleChangePhoto()
        } else if indexPath.row == 1 {
            let destination = ChangePasswordVC()
            baseController?.present(destination, animated: true, completion: nil)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    @objc private func handleChangePhoto() {
        if let window = UIApplication.shared.keyWindow {
            
            let width = CGFloat(window.frame.width - 20)
            let height = CGFloat(150)
            
            photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
            photoOptionsView.baseController = baseController
            photoOptionsView.blackView = blackView
            
            
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                window.addSubview(self.blackView)
                self.blackView.alpha = 0.5
                self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismissPhotoOptions)))
                
                window.addSubview(self.photoOptionsView)
                
                
                self.photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height - height - 20, width: width, height: height)
                
                
            }
        }
    }
    
    @objc private func handleDismissPhotoOptions() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5) {
                let width = CGFloat(window.frame.width - 20)
                let height = CGFloat(150)
                
                self.blackView.alpha = 0
                self.photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
            }
        }
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
