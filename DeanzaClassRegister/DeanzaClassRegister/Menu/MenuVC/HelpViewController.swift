//
//  HelpViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class HelpViewController: MenuBaseViewController {
    let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enrollment Plus"
        label.font = UIFont.boldSystemFont(ofSize: 37)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "Thank you for using our product! We were a five people team, and we were De Anza students when we built this service. Our goal was to make De Anza students' lives better. This app allows De Anza students view and plan their academic schedules; furthermore, we will notify users as the class is available for users to sign up as long as users subscribe the class. \n\nIf you have any feedbacks or comments, please email us: enrollmentplus@gmail.com"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let followLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Follow Us"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let webImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "logo")
        return view
    }()
    
    let facebookImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "facebook")
        return view
    }()
    
    let instagramImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "instagram")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = alphacolor
        navigationItem.title = "About Us"
        self.view.backgroundColor = maincolor
        
        setupBackgroundView()
        setupTitleLabel()
        setupInfoLabel()
        setupFollowLabel()
        setupWebImage()
        setupFacebookImage()
        setupInstagramImage()
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5+88).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        backgroundView.layer.cornerRadius = 10
    }
    
    private func setupTitleLabel() {
        backgroundView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setupInfoLabel() {
        backgroundView.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20+15).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func setupFollowLabel() {
        backgroundView.addSubview(followLabel)
        followLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 35).isActive = true
        followLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15).isActive = true
        followLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        followLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupWebImage() {
        backgroundView.addSubview(webImage)
        webImage.topAnchor.constraint(equalTo: followLabel.bottomAnchor, constant: 22).isActive = true
        webImage.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 38).isActive = true
        webImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        webImage.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(handleWeb(tapGestureRecognizer:)))
        webImage.addGestureRecognizer(tapgesture)
        webImage.isUserInteractionEnabled = true
        
    }
    
    @objc func handleWeb(tapGestureRecognizer: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.enrollment.plus") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    private func setupFacebookImage() {
        backgroundView.addSubview(facebookImage)
        facebookImage.topAnchor.constraint(equalTo: followLabel.bottomAnchor, constant: 5).isActive = true
        facebookImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        facebookImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        facebookImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(handleFacebook(tapGestureRecognizer:)))
        facebookImage.addGestureRecognizer(tapgesture)
        facebookImage.isUserInteractionEnabled = true
    }
    
    @objc func handleFacebook(tapGestureRecognizer: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.facebook.com/enrollmentplus/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    private func setupInstagramImage() {
        backgroundView.addSubview(instagramImage)
        instagramImage.topAnchor.constraint(equalTo: followLabel.bottomAnchor, constant: 5).isActive = true
        instagramImage.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
        instagramImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        instagramImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(handleInstagram(tapGestureRecognizer:)))
        instagramImage.addGestureRecognizer(tapgesture)
        instagramImage.isUserInteractionEnabled = true
    }
    
    @objc func handleInstagram(tapGestureRecognizer: UITapGestureRecognizer) {
        if let url = URL(string: "https://www.instagram.com/enrollmentplus/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}











