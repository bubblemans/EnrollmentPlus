//
//  TableViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/11.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit
import SVProgressHUD

var favoriteList: [BriefData] = []
var planList: [BriefData] = []
var subscribeList: [BriefData] = []
var calendarList: [DetailData] = []
var currentCourses = BriefCourses2D(total: 0, data: [], departmentList: [], isExpanded: [])
var allCourses = BriefCourses2D(total: 0, data: [], departmentList: [], isExpanded: [])
var isFirstTime = true

class TableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    private let cellId = "cellId"
    
    var selectedIndexPath: IndexPath?
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private func downloadCourses() {
        let jsonUrlString = "https://api.enrollment.plus/courses?sortBy=course"
        guard let url = URL(string: jsonUrlString) else { return }
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.alpha = 0.5
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            
            SVProgressHUD.show(withStatus: "Loading...")
            SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    if error?._code == NSURLErrorTimedOut {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Poor Connection...", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                    return
                }
                
                guard let data = data else { return }
                
                if let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) != true{
                    
                    var message = WrongMessage()
                    message = try! JSONDecoder().decode(WrongMessage.self, from: data)
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Oops... failure of downloading the data!", message: message.error, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
                        self.downloadCourses()
                        self.present(alert, animated: true)
                    
                        print ("server error when sign in")
                        SVProgressHUD.dismiss()
                        self.blackView.alpha = 0
                    }
                    return
                }
                
                do {
                    var course = self.sortCourses(courses: try JSONDecoder().decode(BriefCourses.self, from: data))
                    course = self.sortDepartment(courses: course)
                    
                    
                    var index = 0
                    var temp: [BriefData] = []
                    
                    while index < course.total! - 1{
                        temp.append(course.data[index])
                        if course.data[index].department != course.data[index + 1].department {
                            currentCourses.departmentList.append(course.data[index].department!)
                            currentCourses.isExpanded.append(false)
                            currentCourses.data.append(temp)
                            temp = []
                        }
                        index = index + 1
                    }
                    
                    currentCourses.total = course.total
                    allCourses = currentCourses
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let jsonError {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Oops...Sorry, did not connect to the database.", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                        print("Json Error", jsonError)
                    }
                }
                self.downloadSubscribeInfo()
                self.downloadLikeInfo()
                self.downloadCalendarInfo()
                self.getImageUrl()
                
            }.resume()
        }
    }
    
    private func downloadPicture(urlString: String) {
        guard let url = URL(string: "https://api.enrollment.plus"+urlString) else { return }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(token.auth_token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                userImage = UIImage(data: data)
                menuLanucher.profileView.image = userImage
            }
        }.resume()
    }
    
    private func getImageUrl() {
        guard let url = URL(string: "https://api.enrollment.plus/user/information") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(token.auth_token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                if error?._code == NSURLErrorTimedOut {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Poor Connection...", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    }
                }
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) != true{
                DispatchQueue.main.async {
                    print(response)
                    guard let data = data else { return }
                    print(data)
                }
            } else {
                
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    var info = try! JSONDecoder().decode(UserDict.self, from: data)
                    if let urlString = info.user.avatar_url {
                        self.downloadPicture(urlString: urlString)
                    }
                }
            }
        }.resume()
    }
    
    private func downloadSubscribeInfo() {
        let jsonUrlString = "https://api.enrollment.plus/user/subscriptions?type=subscribe"
        guard let url = URL(string: jsonUrlString) else { return }
            
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token.auth_token, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                if error?._code == NSURLErrorTimedOut {
                    
                    let alert = UIAlertController(title: "Poor Connection...", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) != true{
                print(response)
                guard let data = data else { return }
                var message = WrongMessage()
                message = try! JSONDecoder().decode(WrongMessage.self, from: data)
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Oops... failure of downloading the data!", message: message.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
                    self.downloadSubscribeInfo()
                    self.present(alert, animated: true)

                    print ("server error when sign in")
                    SVProgressHUD.dismiss()
                    self.blackView.alpha = 0
                }
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    let crns = try! JSONDecoder().decode([String].self, from: data)
                    subscribeList = self.searchandUpdateList(crns: crns)
                }
            }
        }.resume()
    }
    
    private func downloadCalendarInfo() {
        let jsonUrlString = "https://api.enrollment.plus/user/subscriptions?type=calendar"
        guard let url = URL(string: jsonUrlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token.auth_token, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                if error?._code == NSURLErrorTimedOut {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Poor Connection...", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) != true{
                
                guard let data = data else { return }
                var message = WrongMessage()
                message = try! JSONDecoder().decode(WrongMessage.self, from: data)
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Oops... failure of downloading the data!", message: message.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
                    self.downloadCalendarInfo()
                    self.present(alert, animated: true)
                    print ("server error when sign in")
                    SVProgressHUD.dismiss()
                    self.blackView.alpha = 0
                }
                return
            }
            
            
            if let data = data {
                DispatchQueue.main.async {
                    let crns = try! JSONDecoder().decode([String].self, from: data)
                    planList = self.searchandUpdateList(crns: crns)
                    for course in planList {
                        self.updataCalendarList(at: course)
                    }
                }
            }
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.blackView.alpha = 0
            }
        }.resume()
    }
    
    private func downloadLikeInfo() {
        let jsonUrlString = "https://api.enrollment.plus/user/subscriptions?type=like"
        guard let url = URL(string: jsonUrlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token.auth_token, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                if error?._code == NSURLErrorTimedOut {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Poor Connection...", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) != true{
                
                guard let data = data else { return }
                var message = WrongMessage()
                message = try! JSONDecoder().decode(WrongMessage.self, from: data)
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Oops... failure of downloading the data!", message: message.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
                    self.downloadLikeInfo()
                    self.present(alert, animated: true)
                    
                    print ("server error when sign in")
                    SVProgressHUD.dismiss()
                    self.blackView.alpha = 0
                }
                return
            }

            
            if let data = data {
                DispatchQueue.main.async {
                    let crns = try! JSONDecoder().decode([String].self, from: data)
                    favoriteList = self.searchandUpdateList(crns: crns)
                }
            }
        }.resume()
    }
    
    private func searchandUpdateList(crns: [String])->[BriefData] {
        var list: [BriefData] = []
        for crn in crns {
            for courses in allCourses.data {
                for course in courses {
                    if crn == course.crn! {
                        list.append(course)
                    }
                }
            }
        }
        return list
    }
    
    private func sortCourses(courses: BriefCourses) -> BriefCourses {
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
    
    func sortDepartment(courses: BriefCourses) -> BriefCourses {
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
        
        downloadCourses()
        self.tableView.reloadData()
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "best-poly-backgrounds.png")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.alpha = 0.5
//        setupBackgroundImage()
//        self.tableView.backgroundView = UIImageView(image: UIImage(named: "best-poly-backgrounds.png"))
        setupNavigationbar()

        if isFirstTime {
            downloadCourses()
        } else {
            // TODO: have to save the data somewhere(maybe coredata)
            self.tableView.reloadData()
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchTextField: UITextField? = { [unowned self] in
        var textField: UITextField?
        searchController.searchBar.subviews.forEach({ view in
            view.subviews.forEach({ view in
                if let view  = view as? UITextField {
                    textField = view
                }
            })
        })
        return textField
        }()
    
    private func setupNavigationbar() {
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
        // searchController
        searchController.searchBar.tintColor = maincolor
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        if let bg = self.searchTextField?.subviews.first {
            bg.backgroundColor = #colorLiteral(red: 0.8859924877, green: 0.8859924877, blue: 0.8859924877, alpha: 1)
            bg.alpha = 0.2
            bg.layer.cornerRadius = 10
            bg.clipsToBounds = true
        }
        
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
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = alphacolor
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    open func dismissSearch() {
        searchController.searchBar.endEditing(true)
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
        cell.instructor = currentCourses.data[indexPath.section][indexPath.row].cached_lecture.instructor!
        
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
//            button.setTitle(currentCourses.departmentList[section], for: .normal)
//            button.setTitleColor(maincolor, for: .normal)
//            button.backgroundColor = #colorLiteral(red: 0.3771604213, green: 0.6235294342, blue: 0.57437459, alpha: 1)
            button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.78)
            button.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9137254902, alpha: 1)
//            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.addTarget(self, action: #selector(handleExpand), for: .touchUpInside)
            button.layer.borderWidth = 0.3
            button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            
            let rectangle = UIButton(type: .system)
            rectangle.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
//            rectangle.backgroundColor = .red
            rectangle.frame = CGRect(x: view.center.x, y: 6, width: 151, height: 26)
            rectangle.center.x = view.center.x
            rectangle.layer.cornerRadius = 6
            rectangle.setTitle(currentCourses.departmentList[section], for: .normal)
            rectangle.setTitleColor(maincolor, for: .normal)
            rectangle.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            rectangle.tag = section
            rectangle.addTarget(self, action: #selector(handleExpand), for: .touchUpInside)
            rectangle.layer.shadowOffset = CGSize(width: 0, height: 1)
            rectangle.layer.applySketchShadow(blur: 3, spread: 0)
            button.addSubview(rectangle)
            
            button.tag = section
        } else {
            return button
        }
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
        return 42
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = detailViewController()
        destination.id = currentCourses.data[indexPath.section][indexPath.row].id
        destination.briefData = currentCourses.data[indexPath.section][indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return setupIndexTitle()
//    }
    
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
//        let favorite = favoriteAction(at: indexPath)
        let plan = planAction(at: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [plan])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        
        return swipeAction
    }
    
    private func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            self.updateDataList(at: currentCourses.data[indexPath.section][indexPath.row], with: &favoriteList)
            self.postSubscribe(data: currentCourses.data[indexPath.section][indexPath.row], type: "like")
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "favorite")
        let data = currentCourses.data[indexPath.section][indexPath.row]
        action.backgroundColor = containData(at: data.id, from: favoriteList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    private func planAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "plan") { (action, view, completion) in
            self.handleCalendar(data: currentCourses.data[indexPath.section][indexPath.row])
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "calendar")
        let data = currentCourses.data[indexPath.section][indexPath.row]
        action.backgroundColor = containData(at: data.id, from: planList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    open func handleCalendar(data: BriefData) {
        updateDataList(at: data, with: &planList)
        updataCalendarList(at: data)
        postSubscribe(data: data, type: "calendar")
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let subcribe = subscribeAction(at: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [subcribe])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
    
    private func subscribeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal , title: "subscribe") { (action, view, completion) in
            self.updateDataList(at: currentCourses.data[indexPath.section][indexPath.row], with: &subscribeList)
            self.postSubscribe(data: currentCourses.data[indexPath.section][indexPath.row], type: "subscribe")
            completion(true)
        }
        
        action.image = #imageLiteral(resourceName: "alarm")
        let data = currentCourses.data[indexPath.section][indexPath.row]
        action.backgroundColor = containData(at: data.id, from: subscribeList) != -1 ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        return action
    }
    
    open func containData(at target: Int?, from datas: [BriefData]) -> Int {
        var index = -1
        for indice in datas.indices {
            if datas[indice].id == target! {
                index = Int(indice)
                return index
            }
        }
        return index
    }
    
    open func containData(at target: Int?, from datas: [DetailData]) -> Int {
        var index = -1
        for indice in datas.indices {
            if datas[indice].id == target! {
                index = Int(indice)
                return index
            }
        }
        return index
    }
    
    open func postSubscribe(data: BriefData, type: String) {
        let subscribeInfo = SubscribeJson(crn: data.crn!, type: type)
        let subscribeJson = try! JSONEncoder().encode(subscribeInfo)
        
        let url = URL(string:"https://api.enrollment.plus/subscribe")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token.auth_token, forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = subscribeJson
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                return
            }
            
            if let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) != true{
                
                guard let data = data else { return }
                var message = WrongMessage()
                message = try! JSONDecoder().decode(WrongMessage.self, from: data)
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Oops... failure of adding to the list!", message: message.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    print ("server error when postSubscribe")
                    print(message.error)
                    print(message.errors)
                    print(message.message)
                    SVProgressHUD.dismiss()
                    self.blackView.alpha = 0
                }
                return
            }
        }.resume()
    }
    
    open func updataCalendarList(at data: BriefData) {
        print("updateCalendarList")
        var detailData: DetailData?
        if !calendarList.isEmpty {
            for calendarCourse in calendarList {
                if data.id == calendarCourse.id {
                    // if the element is in the list, it needs to be deleted
                    let index = containData(at: data.id, from: calendarList)
                    calendarList.remove(at: index)
                    postNotiCalendar()
                    return
                }
            }
        }
        let urlString = "https://api.enrollment.plus/courses/" + String(data.id!)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            if let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) != true{
                
                guard let data = data else { return }
                var message = WrongMessage()
                message = try! JSONDecoder().decode(WrongMessage.self, from: data)
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Oops failure of downloading the data!", message: message.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: nil))
                    self.present(alert, animated: true)
            
                    SVProgressHUD.dismiss()
                    self.blackView.alpha = 0
                }
                return
            }
            
            
            guard let data = data else { return }
            
            detailData = try! JSONDecoder().decode(DetailData.self, from: data)
            
            DispatchQueue.main.async {
                guard let newData = detailData else { return }
                calendarList.append(newData)
                self.postNotiCalendar()
            }
        }.resume()
    }
    
    private func postNotiCalendar() {
        let tableVCUpdate = Notification.Name("tableVCUpdate")
        NotificationCenter.default.post(name: tableVCUpdate, object: nil)
    }
    
    open func updateDataList(at target: BriefData, with datas: inout [BriefData]) {
        if datas.isEmpty {
            datas.append(target)
        } else {
            let index = self.containData(at: target.id, from: datas)
            
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
                    
                    let targetText = course.course!.lowercased() + course.cached_lecture.instructor!.lowercased() + course.cached_lecture.instructor!.lowercased() + course.crn!.lowercased()
                    
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

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

