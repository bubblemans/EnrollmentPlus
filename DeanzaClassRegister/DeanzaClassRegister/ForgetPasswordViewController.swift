//
//  ForgetPasswordViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2019/4/5.
//  Copyright © 2019 Alvin Lin. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {
    let backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordLayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    let emailTF: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.placeholder = "Email"
        view.layer.cornerRadius = 4
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.clearButtonMode = .whileEditing
        view.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return view
    }()
    
    let backBT: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bt.setTitle("Back", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 0.4078431373, green: 0.007843137255, blue: 0.1490196078, alpha: 1), for: .normal)
        bt.layer.cornerRadius = 20
        bt.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return bt
    }()

    let sendBT: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        bt.setTitle("Reset", for: .normal)
        bt.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        bt.layer.cornerRadius = 20
        bt.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupBackgroundImage()
        setupTFLayer()
        setupTF()
        setupBackBT()
        setupSendBT()
        
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "best-poly-backgrounds.png")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func setupTFLayer() {
        self.view.addSubview(passwordLayer)
        passwordLayer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        passwordLayer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordLayer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
    }

    private func setupTF() {
        self.view.addSubview(emailTF)
        emailTF.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        emailTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    }
    
    private func setupBackBT() {
        self.view.addSubview(backBT)
        backBT.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 50).isActive = true
        backBT.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backBT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        backBT.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }

    private func setupSendBT() {
        self.view.addSubview(sendBT)
        sendBT.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 50).isActive = true
        sendBT.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendBT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        sendBT.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleReset() {
        let user = User()
        user.email = emailTF.text
        let info = Information(user: user)
        
        guard let url = URL(string: "https://api.enrollment.plus/users/password") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try! JSONEncoder().encode(info)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) != true {
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let user = try! JSONDecoder().decode(WrongUser.self, from: data)
                    let alert = UIAlertController(title: "Fail to reset the password", message: "email is " + user.email![0], preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
                    alert.show()
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Successfully!", message: "Please check your email.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    alert.show()
                }
            }
        }.resume()
        
    }
    
    @objc func textDidChange() {
        if (emailTF.text?.count)! > 0 {
            sendBT.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
            sendBT.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        } else {
            sendBT.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            sendBT.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        }
    }

}









