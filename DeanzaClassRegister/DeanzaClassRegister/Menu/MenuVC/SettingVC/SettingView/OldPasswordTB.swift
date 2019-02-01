//
//  OldPasswordTB.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/19.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class OldPasswordTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    let cellId = "cellId"
    let titleText = ["Old"]
    let placeHolder = ["Old Password"]
    
    let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delegate = self
        dataSource = self
        register(PasswordTableViewCell.self, forCellReuseIdentifier: cellId)
        isScrollEnabled = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PasswordTableViewCell
        cell.titleText = titleText[indexPath.row]
        cell.placeHolder = placeHolder[indexPath.row]
        return cell
    }
    
}
