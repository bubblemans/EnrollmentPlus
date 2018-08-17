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
    
    struct Lectures: Decodable {
        let id: Int?
        let title: String?
        let days: String?
        let times: String?
        let instructor: String?
        let location: String?
        let course_id: Int?
        let created_at: String?
        let updated_at: String?
        
//        init(id: Int? = nil, title: String? = nil, days: String? = nil, times: String? = nil, instructor: String? = nil, location: String? = nil, course_id: Int? = nil, created_at: String? = nil, updated_at: String? = nil) {
//            self.id = id
//            self.title = title
//            self.days = days
//            self.times = times
//            self.instructor = instructor
//            self.location = location
//            self.course_id = course_id
//            self.created_at = created_at
//            self.updated_at = updated_at
//        }
    }
    
    struct Data: Decodable {
        let id: Int?
        let crn: String?
        let course: String?
        let created_at: String?
        let updated_at: String?
        let department: String?
        let status: String?
        let campus: String?
        let units: Double?
        let seats_availible: Int?
        let waitlist_slots_availible: Int?
        let waitlist_slots_capacity: Int?
        let quarter: String?
        var lectures: [Lectures]
        
//        init(id: Int? = nil, crn: String? = nil, course: String? = nil, created_at: String? = nil, updated_at: String? = nil, department: String? = nil, status: String? = nil, campus: String? = nil, units: Double? = nil, seats_availible: Int? = nil, waitlist_slots_availible: Int? = nil, waitlist_slots_capacity: Int? = nil, quarter: String? = nil, lectures: [Lectures]) {
//            self.id = id
//            self.crn = crn
//            self.course = course
//            self.created_at = created_at
//            self.updated_at = updated_at
//            self.department = department
//            self.status = status
//            self.campus = campus
//            self.units = units
//            self.seats_availible = seats_availible
//            self.waitlist_slots_availible = waitlist_slots_availible
//            self.waitlist_slots_capacity = waitlist_slots_capacity
//            self.quarter = quarter
//            self.lectures = lectures
//        }
    }
    
    struct Courses: Decodable {
        let total: Int?
        var data: [Data]
        
//        init(total: Int? = nil, data: [Data]) {
//            self.total = total
//            self.data = data
//        }
    }
    
    var lectureTest = Lectures(id: 0, title: "", days: "", times: "", instructor: "", location: "", course_id: 0, created_at: "", updated_at: "")
    lazy var dataTest = Data(id: 0, crn: "", course: "", created_at: "", updated_at: "", department: "", status: "", campus: "", units: 1.0, seats_availible: 0, waitlist_slots_availible: 0, waitlist_slots_capacity: 0, quarter: "", lectures: [lectureTest])
    lazy var courseTest = Courses(total: 0, data: [dataTest])
    
    func downloadJson(courseTest: Courses) {
        let jsonUrlString = "https://api.daclassplanner.com/courses"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            //            let dataString = String(data: data, encoding: .utf8)
            //
            //            print(dataString as Any)
            
            do {
                //                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                //
                //                print(json)
                
                let course = try JSONDecoder().decode(Courses.self, from: data)
                
                //                guard let total = Courses.total else { return }
                //                print(course.total!)
                
//                var index = 0
//                for _ in course.data {
//                    print(course.data[index].course!, "    ",course.data[index].lectures[0].title!, "    ", course.data[index].lectures[0].instructor!)
//
//                    index = index + 1
//
//                }
                self.courseTest = course
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let jsonError {
                print("Json Error", jsonError)
            }
        }.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Classes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        downloadJson(courseTest: courseTest)
//        self.tableView.reloadData()
        print("done")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return testArray.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courseTest.total!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        // Configure the cell...
//        cell.textLabel?.text = testArray[indexPath.section][indexPath.row]
        let blank = "    "
        
        
//        let text = course + blank + instructor + blank + status
        
        var status: String
        if courseTest.data[indexPath.row].status != nil {
            status = courseTest.data[indexPath.row].status!
        }
        else {
            status = "nil"
        }
        
        let text = courseTest.data[indexPath.row].crn! + blank + courseTest.data[indexPath.row].course! + blank +  courseTest.data[indexPath.row].lectures[0].instructor! + blank + status
        
        cell.textLabel?.text = text
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = sectionTitle[section]
//        label.backgroundColor = UIColor.lightGray
//
//        return label
//    }
    
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
