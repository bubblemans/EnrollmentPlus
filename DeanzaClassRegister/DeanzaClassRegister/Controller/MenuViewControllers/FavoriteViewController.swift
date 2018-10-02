//
//  FavoriteViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class FavoriteViewController: MenuBaseViewController, UITableViewDataSource, UITableViewDelegate {
    let cellId = "cellId"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
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
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite"
        
        if favoriteList.count != 0 {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
            view.addSubview(tableView)
            tableView.frame = view.frame
        } else {
            view.backgroundColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = handleFavorite(at: indexPath)
        let action = UISwipeActionsConfiguration(actions: [favorite])
        return action
    }
    
    private func handleFavorite(at indexpath: IndexPath) -> UIContextualAction{
        let constroller = TableViewController()
        let action = UIContextualAction(style: .destructive, title: "Favorite") { (action, view, completion) in
            let index = constroller.containData(at: favoriteList[indexpath.row], from: favoriteList)
            favoriteList.remove(at: index)
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "star")
        let data = favoriteList[indexpath.row]
        action.backgroundColor = constroller.containData(at: data, from: favoriteList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return action
    }
}
















