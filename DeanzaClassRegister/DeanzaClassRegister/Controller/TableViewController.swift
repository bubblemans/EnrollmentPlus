//
//  TableViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/11.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit
import SVProgressHUD

var favoriteList: [Data] = []
var planList: [Data] = []
var subscribeList: [Data] = []
var isFirstTime = true

class TableViewController: UITableViewController {
    
    private let cellId = "cellId"
    
    var currentCourses = Courses2D(total: 0, data: [], departmentList: [], isExpanded: [])
    var allCourses = Courses2D(total: 0, data: [], departmentList: [], isExpanded: [])
    
    var selectedIndexPath: IndexPath?
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private func downloadJson() {
        let jsonUrlString = "https://api.daclassplanner.com/courses?sortBy=course"
        guard let url = URL(string: jsonUrlString) else { return }
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.alpha = 0.5
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            
            SVProgressHUD.show(withStatus: "Loading...")
            SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    var course = self.sortCourses(courses: try JSONDecoder().decode(Courses.self, from: data))
                    course = self.sortDepartment(courses: course)
                    
                    print(course)
                    
                    var index = 0
                    var temp: [Data] = []
                    
                    while index < course.total! - 1{
                        temp.append(course.data[index])
                        if course.data[index].department != course.data[index + 1].department {
                            self.currentCourses.departmentList.append(course.data[index].department!)
                            self.currentCourses.isExpanded.append(false)
                            self.currentCourses.data.append(temp)
                            temp = []
                        }
                        index = index + 1
                    }
                    
                    self.currentCourses.total = course.total
                    self.allCourses = self.currentCourses
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let jsonError {
                    // TODO: alert
                    print("Json Error", jsonError)
                }
                
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.blackView.alpha = 0
                }
                
                }.resume()
        }
    }
    
    private func sortCourses(courses: Courses) -> Courses {
        var resultCourses = courses
        
        for current in 0..<courses.data.count {
            var min = current
            for walk in current..<courses.data.count {
                if courses.data[min].course! < courses.data[walk].course! {
                    min = walk
                }
                resultCourses.data.swapAt(min, walk)
            }
        }
        resultCourses.total = courses.total
        
        return resultCourses
    }
    
    func sortDepartment(courses: Courses) -> Courses {
        var resultCourses = courses
        var index = 0
        
        while index < resultCourses.data.count {
            resultCourses.data[index].department! = resultCourses.data[index].course!.components(separatedBy: " ")[0]
            index += 1
        }
        
        return resultCourses
    }
    
    @objc private func refreshTableView() {
        currentCourses.data.removeAll()
        currentCourses.total = 0
        
        currentCourses.departmentList.removeAll()
        currentCourses.isExpanded.removeAll()
        
        downloadJson()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationbar()

        if isFirstTime {
            downloadJson()
        } else {
            // TODO: have to save the data somewhere(maybe coredata)
            self.tableView.reloadData()
        }
    }
    
    private func setupNavigationbar() {
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
        // searchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        
        // navigationController
        navigationItem.title = "Classes"
        
        // refreshButton
        let refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTableView))
        navigationItem.rightBarButtonItems = [refreshButtonItem]
        
        // menuButton
        let menubuttonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let menubuttonImage = UIImage(named: "list")
        let menuButton = MenuButton(frame: menubuttonFrame, image: menubuttonImage!)
        menuButton.baseController = self 
        
        navigationItem.rightBarButtonItems = [refreshButtonItem]
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc func printFavoriteList() {
        for i in favoriteList {
            print(i.course!, i.lectures[0].instructor!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return currentCourses.data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if currentCourses.isExpanded.count == 0 {
            return 0
        }

        if currentCourses.isExpanded[section] {
            return currentCourses.data[section].count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        cell.course = currentCourses.data[indexPath.section][indexPath.row].course!
        cell.instructor = currentCourses.data[indexPath.section][indexPath.row].lectures[0].instructor!
        
        if currentCourses.data[indexPath.section][indexPath.row].status != nil {
            cell.status = currentCourses.data[indexPath.section][indexPath.row].status!
        } else {
            cell.status = "nil"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        
        if currentCourses.departmentList.count != 0 {
            button.setTitle(currentCourses.departmentList[section], for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.3771604213, green: 0.6235294342, blue: 0.57437459, alpha: 1)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.addTarget(self, action: #selector(handleExpand), for: .touchUpInside)
        } else {
            return button
        }
        
        button.tag = section

        return button
    }
    
    @objc func handleExpand(button: UIButton) {
        
        var indexPaths = [IndexPath]()
        
        let section = button.tag
        
        for row in currentCourses.data[section].indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        currentCourses.isExpanded[section] = !currentCourses.isExpanded[section]
        
        if currentCourses.isExpanded[section] {
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = detailViewController()
        destination.courses = currentCourses.data[indexPath.section]
        destination.row = indexPath.row
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return setupIndexTitle()
    }
    
    private func setupIndexTitle() -> [String] {
        var indexTitleList: [String] = []
        
        if !currentCourses.departmentList.isEmpty {
            for department in currentCourses.departmentList {
                for char in department {
                    indexTitleList.append(String(char))
                    break
                }
            }
        }
        
        return indexTitleList
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = favoriteAction(at: indexPath)
        let plan = planAction(at: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [favorite, plan])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        
        return swipeAction
    }
    
    private func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            self.updateDataList(at: self.currentCourses.data[indexPath.section][indexPath.row], with: &favoriteList)
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "favorite")
        let data = currentCourses.data[indexPath.section][indexPath.row]
        action.backgroundColor = containData(at: data, from: favoriteList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    private func planAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "plan") { (action, view, completion) in
            self.updateDataList(at: self.currentCourses.data[indexPath.section][indexPath.row], with: &planList)
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "calendar")
        let data = currentCourses.data[indexPath.section][indexPath.row]
        action.backgroundColor = containData(at: data, from: planList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let subcribe = subscribeAction(at: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [subcribe])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
    
    private func subscribeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal , title: "subscribe") { (action, view, completion) in
            self.updateDataList(at: self.currentCourses.data[indexPath.section][indexPath.row], with: &subscribeList)
            
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "alarm")
        let data = currentCourses.data[indexPath.section][indexPath.row]
        action.backgroundColor = containData(at: data, from: subscribeList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    open func containData(at target: Data, from datas: [Data]) -> Int {
        var index = -1
        for indice in datas.indices {
            if datas[indice].crn == target.crn {
                index = Int(indice)
                return index
            }
        }
        return index
    }
    
    open func updateDataList(at target: Data, with datas: inout [Data]) {
        if datas.isEmpty {
            datas.append(target)
        } else {
            let index = self.containData(at: target, from: datas)
            
            if index != -1 {
                datas.remove(at: index)
            } else {
                datas.append(target)
            }
        }
    }

}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        var counter = 0
        
        if let text = searchController.searchBar.text, !text.isEmpty {
            // there is user input
            
            currentCourses.departmentList.removeAll()
            currentCourses.isExpanded.removeAll()
            currentCourses.data.removeAll()
            
            var index = 0
            for departmentCourses in allCourses.data {
                let courses = departmentCourses.filter({ (course) -> Bool in
                    
                    let targetText = course.course!.lowercased() + course.lectures[0].instructor!.lowercased() + course.lectures[0].instructor!.lowercased() + course.crn!.lowercased()
                    
                    if currentCourses.departmentList.isEmpty || course.department != currentCourses.departmentList[currentCourses.departmentList.count - 1] {
                        if targetText.contains(text.lowercased()) {
                            currentCourses.departmentList.append(course.department!)
                            currentCourses.isExpanded.append(true)
                        }
                    }

                    counter += 1
                    return targetText.contains(text.lowercased())
                })
                
                if !courses.isEmpty {
                    
                    currentCourses.data.append(courses)
                    index += 1
                }
            }
            currentCourses.total = counter
            
        } else {
            // no user input
            currentCourses = allCourses
        }
        
        self.tableView.reloadData()
    }
}



