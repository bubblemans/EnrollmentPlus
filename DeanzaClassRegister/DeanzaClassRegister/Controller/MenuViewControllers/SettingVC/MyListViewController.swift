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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My List"
        view.backgroundColor = #colorLiteral(red: 0.9572939277, green: 0.9572939277, blue: 0.9572939277, alpha: 1)
        
        setupScrollView()
        setupSubView()
        setupFavView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = #colorLiteral(red: 0.9572939277, green: 0.9572939277, blue: 0.9572939277, alpha: 1)
        scrollView.contentSize.height = subscribeHeight + favoriteHeight + 100
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupSubView() {
        scrollView.addSubview(subscribeListView)
        subscribeListView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: subscribeHeight)
        subscribeListView.width = view.frame.width
        subscribeListView.setUpTableView()
        subscribeListView.myListController = self
    }
    
    private func setupFavView() {
        scrollView.addSubview(favoriteListView)
        favoriteListView.frame = CGRect(x: 0, y: subscribeHeight, width: view.frame.width, height: favoriteHeight)
        favoriteListView.width = view.frame.width
        favoriteListView.setUpTableView()
        favoriteListView.myListController = self
    }
    
    func animateFavoriteView() {
        if favoriteList.count > 0 {
            UIView.animate(withDuration: 0.5) {
                let newSubHeight = CGFloat(subscribeList.count * 44 + 44)
                let newFavHeight = CGFloat(favoriteList.count * 44 + 44)
                
                self.favoriteListView.frame = CGRect(x: 0, y: newSubHeight, width: self.view.frame.width, height: self.favoriteHeight)
                self.scrollView.contentSize.height = newSubHeight + newFavHeight + 100
            }
        }
    }
    
    func animateScrollView() {
        UIView.animate(withDuration: 0.5) {
            let newSubHeight = CGFloat(subscribeList.count * 44 + 44)
            let newFavHeight = CGFloat(favoriteList.count * 44 + 44)
            
            self.scrollView.contentSize.height = newSubHeight + newFavHeight + 100
        }
    }
}





