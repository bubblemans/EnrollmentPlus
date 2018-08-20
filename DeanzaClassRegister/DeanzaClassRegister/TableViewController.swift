//
//  TableViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/11.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

//    // test 2D array
//    let testArray = [
//        ["CIS22A", "CIS22B", "CIS22C"],
//        ["EWRT1A", "EWRT1B", "EWRT2"],
//        ["MATH1A", "MATH1B", "MATH1C", "MATH1D", "MATH2A", "MATH2B"],
//        ["PHYS4A", "PHYS4B", "PHYS4C", "PHYS4D"]
//    ]
//
//    let sectionTitle = ["CIS", "EWRT", "MATH", "PHYS"]
//
//    let indexTitle = ["C", "E", "M", "P"]
    
    let cellId = "cellId"
    
    var lectureTest = Lectures(id: 0, title: "", days: "", times: "", instructor: "", location: "", course_id: 0, created_at: "", updated_at: "")
    lazy var dataTest = Data(id: 0, crn: "", course: "", created_at: "", updated_at: "", department: "", status: "", campus: "", units: 0.0, seats_availible: 0, waitlist_slots_availible: 0, waitlist_slots_capacity: 0, quarter: "", lectures: [lectureTest])
    lazy var courseTest = Courses2D(total: 0, data: [[dataTest]])
    
    var sectionInfo = SectionInfo(departmentList: [], isExpanded: [])
    var index = 0
    
    func downloadJson() {
        let jsonUrlString = "https://api.daclassplanner.com/courses?sortBy=course"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let course = try JSONDecoder().decode(Courses.self, from: data)
                var index = 0
                var temp: [Data] = []
                self.courseTest.data.remove(at: 0)
                
                while index < course.total! - 1{
                    temp.append(course.data[index])
                    if course.data[index].department != course.data[index + 1].department {
                        self.sectionInfo.departmentList.append(course.data[index].department!)
                        self.sectionInfo.isExpanded.append(true)
                        self.courseTest.data.append(temp)
                        temp = []
                    }
                    index = index + 1
                }
                self.courseTest.total = course.total
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let jsonError {
                print("Json Error", jsonError)
            }
        }.resume()
    }
    
    @objc func reloadTableView() {
        print("test reset button")
        courseTest.data.remove(at: 0)
        sectionInfo.departmentList.remove(at: 0)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.title = "Classes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reloadTableView))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        downloadJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return courseTest.data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if sectionInfo.isExpanded.count == 0 {
            return 0
        }
        
        if sectionInfo.isExpanded[section] {
            return courseTest.data[section].count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
        let blank = "    "
        
        
        var status: String
        if courseTest.data[indexPath.section][indexPath.row].status != nil {
            status = courseTest.data[indexPath.section][indexPath.row].status!
        } else {
            status = "nil"
        }
        
        let text = courseTest.data[indexPath.section][indexPath.row].crn! + blank + courseTest.data[indexPath.section][indexPath.row].course! + blank +  courseTest.data[indexPath.section][indexPath.row].lectures[0].instructor! + blank + status
        
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
        
        for row in courseTest.data[section].indices {
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
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return indexTitle
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
