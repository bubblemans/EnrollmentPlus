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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 16 * 70 + 50
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupDayView()
        setupCalendarView()
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
        calendarView.frame = CGRect(x: 0, y: dayView.frame.maxY + 50, width: 414, height: 16 * 70)
    }
    
    private func setupDayView() {
        view.addSubview(dayView)
        dayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
        dayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dayView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    
}







