//
//  MyListViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/1.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class MyListViewController: MenuBaseViewController {
    
    let subscribeListView = SubscribeList()
    let favoriteListView = FavoriteList()
    
    
    override func viewDidLoad() {
        
        navigationItem.title = "List"
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9572939277, green: 0.9572939277, blue: 0.9572939277, alpha: 1)
        view.addSubview(subscribeListView)
        view.addSubview(favoriteListView)
        
        let subscribeHeight = CGFloat(subscribeList.count * 60)
        let favoriteHeight = CGFloat(favoriteList.count * 60)
        
        subscribeListView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: subscribeHeight)
        favoriteListView.frame = CGRect(x: 0, y: 130 + subscribeHeight, width: view.frame.width, height: favoriteHeight)
    }
}





