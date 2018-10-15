//
//  SettingViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

let preferenceOption = ["Edit Profile", "Change Photo", "Change Password"]
let notiOption = ["Push Notification", "Email Notification"]
let prefIcon = ["profile", "camera", "lock"]
let notiIcon = ["subscribe", "mail"]

class SettingViewController: MenuBaseViewController {
    
    let preferenceView: PreferenceView = {
        let view = PreferenceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let notifView: NotificationView = {
        let view = NotificationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        navigationItem.title = "Setting"
        
        setupPreferenceView()
        setupNotiView()
    }
    
    private func setupPreferenceView() {
        let count = CGFloat(preferenceOption.count)
        view.addSubview(preferenceView)
        preferenceView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        preferenceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        preferenceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        preferenceView.heightAnchor.constraint(equalToConstant: 44 * count + 44).isActive = true
        
        preferenceView.baseController = self
    }
    
    private func setupNotiView() {
        
        let count = CGFloat(notiOption.count)
        view.addSubview(notifView)
        notifView.topAnchor.constraint(equalTo: preferenceView.bottomAnchor, constant: 44).isActive = true
        notifView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notifView.heightAnchor.constraint(equalToConstant: 44 * count + 44).isActive = true
        notifView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}







