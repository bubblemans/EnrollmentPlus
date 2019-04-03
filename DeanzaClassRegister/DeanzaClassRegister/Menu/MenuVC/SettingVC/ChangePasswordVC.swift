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
            let user = ChangeUser()
            user.password = newPassword
            let info = ChangeInfo()
            info.user = user
            let userJson = try! JSONEncoder().encode(info)

            guard let url = URL(string: "https://api.daclassplanner.com/users") else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(token.auth_token, forHTTPHeaderField: "Authorization")
            urlRequest.httpMethod = "PATCH"
            urlRequest.httpBody = userJson

            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

                if error != nil {
                    if error?._code == NSURLErrorTimedOut {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Poor Connection...", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) != true {
                    if let data = data {
                        let message = try! JSONDecoder().decode(WrongUser.self, from: data)
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Password", message: message.password?[0], preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    } else {
                        print("no data")
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Congratulations!", message: "Successfully change password!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }.resume()
        } else {
            let alert = UIAlertController(title: "WARNING", message: "Confirmed password is not correct!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
            self.present(alert, animated: true)
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







