//
//  NotificationViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class NotificationViewController: MenuBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}













