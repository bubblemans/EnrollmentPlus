//
//  MenuBaseViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/18.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class MenuBaseViewController: UIViewController {
    
    var baseController: TableViewController?
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menubuttonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let menubuttonImage = UIImage(named: "list")?.withRenderingMode(.alwaysTemplate)
        let menuButton = MenuButton(frame: menubuttonFrame, image: menubuttonImage!)
        menuButton.tintColor = .black
        menuButton.baseController = baseController
        menuButton.selectedIndexPath = selectedIndexPath
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
}

