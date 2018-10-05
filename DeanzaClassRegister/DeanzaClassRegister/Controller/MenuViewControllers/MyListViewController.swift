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
    let subscribeHeight = CGFloat(subscribeList.count * 44 + 44)
    let favoriteHeight = CGFloat(favoriteList.count * 44 + 44)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My List"
        view.backgroundColor = #colorLiteral(red: 0.9572939277, green: 0.9572939277, blue: 0.9572939277, alpha: 1)
        view.addSubview(subscribeListView)
        view.addSubview(favoriteListView)
        subscribeListView.myListController = self
        
        subscribeListView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: subscribeHeight)
        favoriteListView.frame = CGRect(x: 0, y: 100 + 30 + subscribeHeight, width: view.frame.width, height: favoriteHeight)
    }
    
    open func animateFavoriteView() {
        if favoriteList.count > 0 && subscribeList.count == 0{
            UIView.animate(withDuration: 0.5) {
                print("hehe")
                self.favoriteListView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.favoriteHeight)
            }
        }
    }
}





