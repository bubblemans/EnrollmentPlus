//
//  EditProfileViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/12.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var baseController: TableViewController?
    
    let titleNames = ["First Name", "Last Name", "Email"]
    let cellId = "cellId"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EditProfileCell
        cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.selectionStyle = .none
        cell.title = titleNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
    
    let navigationView: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = alphacolor
        return bar
    }()
    
    let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = userImage
        imageView.tintColor = .black
        return imageView
    }()
    
    let photoOptionsView: PhotoOptionTableView = {
        let view = PhotoOptionTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = alphacolor
        setupNavBar()
        setupPhotoView()
//        setupTableView()
    }
    
    let cancelButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return bt
    }()
    
    let saveButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return bt
    }()
    
    @objc private func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSave() {
        print("save")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Edit Profile"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private func setupNavBar() {
        view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navigationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        // cancel button
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(maincolor, for: .normal)
        navigationView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // save button
//        saveButton.setTitle("Save", for: .normal)
//        saveButton.setTitleColor(maincolor, for: .normal)
//        navigationView.addSubview(saveButton)
//        saveButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor).isActive = true
//        saveButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
//        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // title label
        navigationView.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupPhotoView() {
        view.addSubview(photoView)
        photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        photoView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 60).isActive = true
        photoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    
        photoView.layer.cornerRadius = 90
        photoView.contentMode = .scaleToFill
        photoView.clipsToBounds = true
 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePhoto))
        photoView.addGestureRecognizer(tapGesture)
        photoView.isUserInteractionEnabled = true
    }
    
    @objc private func handlePhoto() {
        if let window = UIApplication.shared.keyWindow {
            
            let width = CGFloat(window.frame.width - 20)
            let height = CGFloat(150)
            
            photoOptionsView.frame = CGRect(x: (window.frame.width - width) / 2, y: window.frame.height, width: width, height: height)
            photoOptionsView.baseController = self
            photoOptionsView.blackView = blackView
            photoOptionsView.photoView = photoView
            
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
    
    private func setupTableView() {
        let count = CGFloat(titleNames.count)
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 40).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 44 * count).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: cellId)
        
        tableView.isScrollEnabled = false
    }
}
