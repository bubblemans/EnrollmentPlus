//
//  NotificationViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class NotificationViewController: MenuBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    
    }
}













