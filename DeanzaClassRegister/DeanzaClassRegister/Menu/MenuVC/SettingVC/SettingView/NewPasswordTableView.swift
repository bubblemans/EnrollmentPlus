//
//  NewPasswordTableView.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/19.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class NewPasswordTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    let cellId = "cellId"
    let titleText = ["New", "Confirm"]
    let placeHolder = ["New Password", "Confirm Password"]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        dataSource = self
        delegate = self
        register(NewPasswordTBCell.self, forCellReuseIdentifier: cellId)
        isScrollEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewPasswordTBCell
        cell.titleText = titleText[indexPath.row]
        cell.placeHolder = placeHolder[indexPath.row]
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
    
    
}
