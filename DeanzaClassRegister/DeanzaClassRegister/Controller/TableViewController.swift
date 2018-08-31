//
//  TableViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/11.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    private let cellId = "cellId"
    
    var currentCourses = Courses2D(total: 0, data: [], departmentList: [], isExpanded: [])
    var allCourses = Courses2D(total: 0, data: [], departmentList: [], isExpanded: [])
    
    private func downloadJson() {
        let jsonUrlString = "https://api.daclassplanner.com/courses?sortBy=course"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                var course = self.sortCourses(courses: try JSONDecoder().decode(Courses.self, from: data))
                course = self.sortDepartment(courses: course)
                
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
        }.resume()
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
    
    @objc func reloadTableView() {
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
        
        downloadJson()
        
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
        
            // leftbarButton
        let buttonframe = CGRect(x: 0, y: 0, width: 25, height: 25)
        let buttonImage = UIImage(named: "refresh")
        
        let reloadButtomItem = UIButton(frame: buttonframe)
        
        reloadButtomItem.widthAnchor.constraint(equalToConstant: buttonframe.width).isActive = true
        reloadButtomItem.heightAnchor.constraint(equalToConstant: buttonframe.height).isActive = true
        
        reloadButtomItem.setImage(buttonImage, for: UIControlState())
        reloadButtomItem.addTarget(self, action: #selector(reloadTableView), for: .touchUpInside)
        reloadButtomItem.contentMode = .scaleAspectFit
        reloadButtomItem.tintColor = UIColor.blue
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: reloadButtomItem)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
        

//        // Configure the cell...
//        let blank = "    "
//        var status: String
//        
//        if currentCourses.data[indexPath.section][indexPath.row].status != nil {
//            status = currentCourses.data[indexPath.section][indexPath.row].status!
//        } else {
//            // transform json's null to swift's nil
//            status = "nil"
//        }
//        
//        let text = currentCourses.data[indexPath.section][indexPath.row].crn! + blank + currentCourses.data[indexPath.section][indexPath.row].course! + blank +  currentCourses.data[indexPath.section][indexPath.row].lectures[0].instructor! + blank + status
//        
//        cell.textLabel?.text = text
//        cell.textLabel?.numberOfLines = 2
        
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
            button.backgroundColor = UIColor.gray
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
                    
                    let targetText = course.course!.lowercased() + course.crn! + course.lectures[0].instructor!.lowercased()
                    
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
            
            currentCourses.departmentList.removeAll()
            currentCourses.isExpanded.removeAll()
            
            for departmentCourses in allCourses.data {
                currentCourses.departmentList.append(departmentCourses[0].department!)
                currentCourses.isExpanded.append(true)
            }
            currentCourses = allCourses
        }
        
        self.tableView.reloadData()
    }
}
