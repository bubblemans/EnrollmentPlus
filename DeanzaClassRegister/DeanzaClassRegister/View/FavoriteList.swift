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
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = handleFavorite(at: indexPath)
        let action = UISwipeActionsConfiguration(actions: [delete])
        return action
    }
    
    private func handleFavorite(at indexPath: IndexPath) -> UIContextualAction {
        
        let controller = TableViewController()
        let data = favoriteList[indexPath.row]
        let index = controller.containData(at: data, from: favoriteList)
        
        let action = UIContextualAction(style: .destructive, title: "favorite") { (action, view, completion) in
            favoriteList.remove(at: index)
            self.tableView.reloadData()
            self.tableView.frame = CGRect(x: 0, y: 44, width: 375, height: CGFloat(favoriteList.count * 44))
            
            if favoriteList.count == 0 {
                self.dismissTableView()
            }
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "star")
        action.backgroundColor = controller.containData(at: data, from: favoriteList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    private func dismissTableView() {
        UIView.animate(withDuration: 0.5) {
            self.tableView.alpha = 0
            self.headerLabel.alpha = 0
        }
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "  Like"
        label.textAlignment = .left
        label.backgroundColor = #colorLiteral(red: 0.9572939277, green: 0.9572939277, blue: 0.9572939277, alpha: 1)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let height = CGFloat(favoriteList.count * 44)
        
        tableView.isScrollEnabled = false
        tableView.frame = CGRect(x: 0, y: 44, width: 375, height: height)
        addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
        if favoriteList.count > 0 {
            headerLabel.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
            addSubview(headerLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}





