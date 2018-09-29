//
//  SubscribeViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/9/14.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class SubscribeViewController: MenuBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.course = subscribeList[indexPath.row].course!
        cell.instructor = subscribeList[indexPath.row].lectures[0].instructor!
        
        if subscribeList[indexPath.row].status != nil {
            cell.status = subscribeList[indexPath.row].status!
        } else {
            cell.status = "nil"
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.title = "Subscribe"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3771604213, green: 0.6235294342, blue: 0.57437459, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let subscribe = subscribeAction(at: indexPath)
        let action = UISwipeActionsConfiguration(actions: [subscribe])
        
        return action
    }
    
    private func subscribeAction(at indexPath: IndexPath) -> UIContextualAction{
        let controller = TableViewController()
        let action = UIContextualAction(style: .destructive, title: "subscribe") { (action, view, completion) in
            
            let index = controller.containData(at: subscribeList[indexPath.row], from: subscribeList)
            if index != -1 {
                subscribeList.remove(at: index)
            } else {
                print("Can't find the data.")
            }
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "alarm")
        let data = subscribeList[indexPath.row]
        action.backgroundColor = controller.containData(at: data, from: subscribeList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return action
    }
}














