//
//  CalendarVC.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/11/21.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class CalendarVC: MenuBaseViewController {
    
    let width = 414.0
    var numOfDays = 0
    var numOfClass = 0
    let colors = [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
    var x = [0.0, 0.0, 0.0, 0.0, 0.0]
    var y = 0.0
    // let wid = width / 6
    var height = 0.0
    
    let tableVCUpdate = Notification.Name("tableVCUpdate")
    let detailVCUpdate = Notification.Name("detailYCUpdate")
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 17 * 70 + 50
        view.backgroundColor = .white
        return view
    }()
    
    let dayView: CalendarDayView = {
        let view = CalendarDayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let calendarView: CalendarView = {
        let view = CalendarView()
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var classesButton = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservers()
        setupScrollView()
        setupDayView()
        setupCalendarView()
        for i in calendarList {
            insertClass(data: i)
            numOfClass = numOfClass + 1
            renewFrame()
        }
        numOfClass = 0
    }
    
    private func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupCalendar), name: tableVCUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupCalendar), name: detailVCUpdate, object: nil)
    }
    
    @objc private func setupCalendar() {
        for view in scrollView.subviews {
            for bt in classesButton {
                if view == bt {
                    view.frame = .zero
                    view.removeFromSuperview()
                }
            }
        }
        for i in calendarList {
            insertClass(data: i)
            numOfClass = numOfClass + 1
            renewFrame()
        }
        numOfClass = 0
        print(calendarList)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setupCalendarView() {
        scrollView.addSubview(calendarView)
        calendarView.frame = CGRect(x: 0, y: dayView.frame.maxY + 50, width: 414, height: 17 * 70)
    }
    
    private func setupDayView() {
        view.addSubview(dayView)
        dayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        dayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func insertClass(data: Data) {
        insertByDay(days: data.lectures[0].days!)
        insertByTime(time: data.lectures[0].times!)
        
        let wid = width / 6 - 2
        
        if x[0] != 0 {
            let button = UIButton()
            button.frame = CGRect(x: x[0], y: y, width: wid, height: height)
            button.layer.cornerRadius = 10
            button.backgroundColor = colors[numOfClass]
            button.setTitle(data.course!, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            classesButton.append(button)
        }
        if x[1] != 0 {
            let button = UIButton()
            button.frame = CGRect(x: x[1], y: y, width: wid, height: height)
            button.layer.cornerRadius = 10
            button.backgroundColor = colors[numOfClass]
            button.setTitle(data.course!, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            classesButton.append(button)
        }
        if x[2] != 0 {
            let button = UIButton()
            button.frame = CGRect(x: x[2], y: y, width: wid, height: height)
            button.layer.cornerRadius = 10
            button.backgroundColor = colors[numOfClass]
            button.setTitle(data.course!, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            classesButton.append(button)
        }
        if x[3] != 0 {
            let button = UIButton()
            button.frame = CGRect(x: x[3], y: y, width: wid, height: height)
            button.layer.cornerRadius = 10
            button.backgroundColor = colors[numOfClass]
            button.setTitle(data.course!, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            classesButton.append(button)
        }
        if x[4] != 0 {
            let button = UIButton()
            button.frame = CGRect(x: x[4], y: y, width: wid, height: height)
            button.layer.cornerRadius = 10
            button.backgroundColor = colors[numOfClass]
            button.setTitle(data.course!, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12)
            classesButton.append(button)
        }
        
        for bt in classesButton {
            scrollView.addSubview(bt)
        }
    }
    
    private func insertByDay(days: String) {
        let wid = width / 6

        if days[0] == "M" {
            x[0] = wid + 1
            numOfDays = numOfDays + 1
        }
        if days[1] == "T" {
            x[1] = 2 * wid + 1
            numOfDays = numOfDays + 1
        }
        if days[2] == "W" {
            x[2] = 3 * wid + 1
            numOfDays = numOfDays + 1
        }
        if days[3] == "R" {
            x[3] = 4 * wid + 1
            numOfDays = numOfDays + 1
        }
        if days[4] == "F" {
            x[4] = 5 * wid + 1
            numOfDays = numOfDays + 1
        }
    }
    
    private func insertByTime(time: String) {
        let startHour = time[0..<2]
        let startMinute = time[3..<5]
        let endHour = time[9..<11]
        let endMinute = time[12..<14]
        let startAmOrPm = time[6..<8]
        let endAmOrPm = time[15..<17]
        
        if startAmOrPm == "AM" {
            guard let startHour = Double(startHour) else { return }
            guard let startMinute = Double(startMinute) else { return }
            y = 49 + (startHour - 7) * 70 + Double(startMinute) / Double(60.0) * Double(70)
        } else if startAmOrPm == "PM" {
            guard let startHour = Double(startHour) else { return }
            guard let startMinute = Double(startMinute) else { return }
            y = 49 + (startHour - 7 + 12) * 70 + Double(startMinute) / Double(60.0) * Double(70)
        }
        
        var endingY = 0.0
        if endAmOrPm == "AM" {
            guard let endHour = Double(endHour) else { return }
            guard let endMinute = Double(endMinute) else { return }
            endingY = Double(49) + Double(endHour - 7) * Double(70)
            let minute = Double(endMinute) / Double(60.0) * Double(70)
            endingY = endingY + minute
        } else if endAmOrPm == "PM" {
            guard let endHour = Double(endHour) else { return }
            guard let endMinute = Double(endMinute) else { return }
            endingY = Double(49) + Double(endHour - 7 + 12) * Double(70)
            let minute = Double(endMinute) / Double(60.0) * Double(70)
            endingY = endingY + minute
        }
        height = endingY - y
    }
    
    private func renewFrame() {
        for i in x.indices {
            x[i] = 0
        }
        y = 0
        height = 0
    }
    
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}







