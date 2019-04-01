//
//  ChangePasswordVC.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/19.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

var email: String?
var oldPassword: String?
var newPassword: String?
var confirmPassword: String?

class ChangePasswordVC: UIViewController {
    let cellId = "cellId"
    
    let navigationView: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = #colorLiteral(red: 0.3771604213, green: 0.6235294342, blue: 0.57437459, alpha: 1)
        return bar
    }()
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Change Password"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let OldPasswordTB: OldPasswordTableView = {
        let view = OldPasswordTableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let NewPasswordTB: NewPasswordTableView = {
        let view = NewPasswordTableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc private func handleSave() {
        print("save")
        if confirmPassword! == newPassword! {
            let user = User(email: email!, password: newPassword!, name: "")
            let info = Information(user: user)
            let userJson = try! JSONEncoder().encode(info)

            guard let url = URL(string: "https://api.daclassplanner.com/users") else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = userJson

            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

                if let error = error {
                    print(error)
                    return
                } else {
                    print("no error")
                }
                
                if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) != true {
                    print(response)
//                    return
                }

                if let data = data {
                    print(data)
                    var message = WrongMessage()
                    message = try! JSONDecoder().decode(WrongMessage.self, from: data)
//                    print(String(data: message.error!, encoding: .uft8))
                    print(message.error)
                    print(message.message)
                    if let message = message.message {
                        print(message)
                    } else {
                        print("no meesage")
                    }
                } else {
                    print("no data")
                }
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }.resume()
        } else {
            print("new password is not confirmed password")
        }
    }
    
    @objc private func handleCancel() {
        cleanPassword()
        self.dismiss(animated: true, completion: nil)
    }
    
    func cleanPassword() {
        oldPassword = ""
        newPassword = ""
        confirmPassword = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        setupNavBar()
        setupOldTB()
        setupNewTB()
    }
    
    private func setupNavBar() {
        view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navigationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        // cancel button
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        navigationView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // save button
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        navigationView.addSubview(saveButton)
        saveButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // title label
        navigationView.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupOldTB() {
        view.addSubview(OldPasswordTB)
        OldPasswordTB.topAnchor.constraint(equalTo: view.topAnchor, constant: 88 + 10).isActive = true
        OldPasswordTB.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        OldPasswordTB.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        OldPasswordTB.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupNewTB() {
        view.addSubview(NewPasswordTB)
        NewPasswordTB.topAnchor.constraint(equalTo: OldPasswordTB.bottomAnchor, constant: 44).isActive = true
        NewPasswordTB.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NewPasswordTB.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        NewPasswordTB.heightAnchor.constraint(equalToConstant: 88).isActive = true
    }
}







