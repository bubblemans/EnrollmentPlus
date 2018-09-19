//
//  MenuBarButton.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/15.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class MenuBarButton: UIBarButtonItem {
    
    var baseController: TableViewController?
    var searchController: UISearchController?
    
    override init() {
        super.init()
        
        // menuButton
        let menubuttonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let menubuttonImage = UIImage(named: "list")
        
        let menuButtonItem = UIButton(frame: menubuttonFrame)
        
        menuButtonItem.widthAnchor.constraint(equalToConstant: menubuttonFrame.width).isActive = true
        menuButtonItem.heightAnchor.constraint(equalToConstant: menubuttonFrame.height).isActive = true
        
        menuButtonItem.setImage(menubuttonImage, for: UIControlState())
        menuButtonItem.addTarget(self, action: #selector(baseController?.handleMenu), for: .touchUpInside)
        menuButtonItem.contentMode = .scaleAspectFit
        
        
//        baseController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButtonItem)
        
        baseController?.navigationController?.navigationBar.prefersLargeTitles = true
        baseController?.navigationItem.searchController = searchController
        baseController?.navigationItem.hidesSearchBarWhenScrolling = false
        
        print("hehe")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
