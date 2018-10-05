//
//  SubscribeList.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/10/1.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class SubscribeList: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    var myListController: MyListViewController?
    
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = handleSubscribe(at: indexPath)
        let action = UISwipeActionsConfiguration(actions: [delete])
        return action
    }
    
    private func handleSubscribe(at indexPath: IndexPath) -> UIContextualAction {
        
        let controller = TableViewController()
        let data = subscribeList[indexPath.row]
        let index = controller.containData(at: data, from: subscribeList)
        
        let action = UIContextualAction(style: .destructive, title: "subscribe") { (action, view, completion) in
            subscribeList.remove(at: index)
            self.tableView.reloadData()
            self.tableView.frame = CGRect(x: 0, y: 44, width: 375, height: CGFloat(subscribeList.count * 44))
            
            if subscribeList.count == 0 {
                self.dismissTableView()
                self.myListController?.animateFavoriteView()
            }
            
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "alarm")
        action.backgroundColor = controller.containData(at: data, from: subscribeList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribeList.count
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
        let headerLabel = UILabel()
        headerLabel.text = "  Subscribe"
        headerLabel.textAlignment = .left
        headerLabel.backgroundColor = #colorLiteral(red: 0.9572939277, green: 0.9572939277, blue: 0.9572939277, alpha: 1)
        headerLabel.textColor = .darkGray
        return headerLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let height = CGFloat(subscribeList.count * 44)
        
        
        tableView.frame = CGRect(x: 0, y: 44, width: 375, height: height)
        tableView.isScrollEnabled = false
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
        if subscribeList.count > 0 {
            headerLabel.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
            addSubview(headerLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
