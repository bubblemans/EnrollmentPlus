//
//  FavoriteList.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/1.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class FavoriteList: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        
        cell.course = favoriteList[indexPath.row].course!
        cell.instructor = favoriteList[indexPath.row].lectures[0].instructor!
        
        if favoriteList[indexPath.row].status != nil {
            cell.status = favoriteList[indexPath.row].status!
        } else {
            cell.status = "nil"
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "  Like"
        label.textAlignment = .left
        label.backgroundColor = #colorLiteral(red: 0.9572939277, green: 0.9572939277, blue: 0.9572939277, alpha: 1)
        label.textColor = .darkGray
        return label
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let height = CGFloat(favoriteList.count * 60)
        
        tableView.isScrollEnabled = false
        tableView.frame = CGRect(x: 0, y: 0, width: 375, height: height)
        addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}





