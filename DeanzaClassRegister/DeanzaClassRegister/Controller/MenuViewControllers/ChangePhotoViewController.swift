//
//  ChangePhotoViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/12.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class ChangePhotoViewController: UIViewController {
    
    let photoView: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .green
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
