//
//  TableViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/11.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let cellId = "cellId"
    
    var currentCourses = Courses2D(total: 0, data: [])
    var allCourses = Courses2D(total: 0, data: [])
    
    var sectionInfo = SectionInfo(departmentList: [], isExpanded: [])
    
    func downloadJson() {
        let jsonUrlString = "https://api.daclassplanner.com/courses?sortBy=course"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let course = try JSONDecoder().decode(Courses.self, from: data)
                var index = 0
                var temp: [Data] = []
                
                while index < course.total! - 1{
                    temp.append(course.data[index])
                    if course.data[index].department != course.data[index + 1].department {
                        self.sectionInfo.departmentList.append(course.data[index].department!)
                        self.sectionInfo.isExpanded.append(true)
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
                print("Json Error", jsonError)
            }
        }.resume()
    }
    
    @objc func reloadTableView() {
        currentCourses.data.removeAll()
        currentCourses.total = 0
        
        sectionInfo.departmentList.removeAll()
        sectionInfo.isExpanded.removeAll()
        
        downloadJson()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationbar()
        
        downloadJson()
        
    }
    
    private func setupNavigationbar() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        
        navigationItem.title = "Classes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reloadTableView))
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
        
        if sectionInfo.isExpanded.count == 0 {
            return 0
        }
        
        if sectionInfo.isExpanded[section] {
            return currentCourses.data[section].count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
        let blank = "    "
        
        
        var status: String
        if currentCourses.data[indexPath.section][indexPath.row].status != nil {
            status = currentCourses.data[indexPath.section][indexPath.row].status!
        } else {
            status = "nil"
        }
        
        let text = currentCourses.data[indexPath.section][indexPath.row].crn! + blank + currentCourses.data[indexPath.section][indexPath.row].course! + blank +  currentCourses.data[indexPath.section][indexPath.row].lectures[0].instructor! + blank + status
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        
        if sectionInfo.departmentList.count != 0 {
            button.setTitle(sectionInfo.departmentList[section], for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.lightGray
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
        
        sectionInfo.isExpanded[section] = !sectionInfo.isExpanded[section]
        
        if sectionInfo.isExpanded[section] {
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
            
            sectionInfo.departmentList.removeAll()
            sectionInfo.isExpanded.removeAll()
            currentCourses.data.removeAll()
            
            for departmentCourses in allCourses.data {
                let courses = departmentCourses.filter({ (course) -> Bool in
                    if course.course!.lowercased().contains(text.lowercased()), sectionInfo.departmentList.isEmpty || course.department != sectionInfo.departmentList[sectionInfo.departmentList.count - 1] {
                        sectionInfo.departmentList.append(course.department!)
                        sectionInfo.isExpanded.append(true)
                    }
                    counter += 1
                    return course.course!.lowercased().contains(text.lowercased())
                })
                if !courses.isEmpty {
                    currentCourses.data.append(courses)
                }
            }
            currentCourses.total = counter
        } else {
            sectionInfo.departmentList.removeAll()
            sectionInfo.isExpanded.removeAll()
            
            for departmentCourses in allCourses.data {
                sectionInfo.departmentList.append(departmentCourses[0].department!)
                sectionInfo.isExpanded.append(true)
            }
            currentCourses = allCourses
        }
        
        self.tableView.reloadData()
    }
}
