//
//  detailViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/23.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    var courses: [Data] = []
    var row = 0
    lazy var course = courses[row]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = course.course!
        
        setUpScrollView()

    }
    
    func setUpScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    
        
        setUpInfoView()
        setUpProfileView()
        setUpClockView()
        setUpLocationView()
        setUpStatsView()
        
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1000
        view.backgroundColor = #colorLiteral(red: 0.3771604213, green: 0.6235294342, blue: 0.57437459, alpha: 1)
        return view
    }()
    
    func setUpInfoView() {
        let infoView = UIView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = .white
        scrollView.addSubview(infoView)
        
        infoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        infoView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        infoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        let infoImage = UIImageView()
        infoImage.image = UIImage(named: "info")
        infoImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        infoImage.contentMode = .scaleAspectFit
        infoView.addSubview(infoImage)
        
        let titleLabel = UILabel()
        titleLabel.text = "Course  Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        infoView.addSubview(titleLabel)
        
        let trailingTitleLabel = UILabel()
        trailingTitleLabel.text = course.lectures[0].title!
        trailingTitleLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        if (trailingTitleLabel.text?.count)! > 60 {
            trailingTitleLabel.frame = CGRect(x: 120, y: 115, width: 250, height: 70)
            trailingTitleLabel.numberOfLines = 3
        } else if (trailingTitleLabel.text?.count)! > 25 {
            trailingTitleLabel.frame = CGRect(x: 120, y: 135, width: 250, height: 50)
            trailingTitleLabel.numberOfLines = 2
        } else {
            trailingTitleLabel.frame = CGRect(x: 120, y: 135, width: 250, height: 30)
        }
        infoView.addSubview(trailingTitleLabel)
        
        let leadingTitleLabel = UILabel()
        leadingTitleLabel.text = "Title"
        leadingTitleLabel.textColor = .black
        if (trailingTitleLabel.text?.count)! > 60 {
            leadingTitleLabel.frame = CGRect(x: 15, y: 115, width: 100, height: 30)
        } else {
            leadingTitleLabel.frame = CGRect(x: 15, y: 135, width: 100, height: 30)
        }
        infoView.addSubview(leadingTitleLabel)
        
        let leadingCourseLabel = UILabel()
        leadingCourseLabel.text = "Course"
        leadingCourseLabel.textColor = .black
        leadingCourseLabel.frame = CGRect(x: 15, y: 55, width: 100, height: 30)
        infoView.addSubview(leadingCourseLabel)
        
        let trailingCourseLabel = UILabel()
        trailingCourseLabel.text = course.course!
        trailingCourseLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingCourseLabel.frame = CGRect(x: 120, y: 55, width: 100, height: 30)
        infoView.addSubview(trailingCourseLabel)
        
        let leadingCRNLabel = UILabel()
        leadingCRNLabel.text = "CRN"
        leadingCRNLabel.textColor = .black
        if (trailingTitleLabel.text?.count)! > 60 {
            leadingCRNLabel.frame = CGRect(x: 15, y: 85, width: 100, height: 30)
        } else {
            leadingCRNLabel.frame = CGRect(x: 15, y: 95, width: 100, height: 30)
        }
        infoView.addSubview(leadingCRNLabel)
        
        let trailingCRNLabel = UILabel()
        trailingCRNLabel.text = course.crn!
        trailingCRNLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        if (trailingTitleLabel.text?.count)! > 60 {
            trailingCRNLabel.frame = CGRect(x: 120, y: 85, width: 100, height: 30)
        } else {
            trailingCRNLabel.frame = CGRect(x: 120, y: 95, width: 100, height: 30)
        }
        infoView.addSubview(trailingCRNLabel)
    }
    
    func setUpProfileView() {
        let profileView = UIView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.backgroundColor = .white
        
        scrollView.addSubview(profileView)
        profileView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 220).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "profile")
        profileImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        profileImage.contentMode = .scaleAspectFit
        profileView.addSubview(profileImage)
        
        let titleLabel = UILabel()
        titleLabel.text = "Instructor  Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        profileView.addSubview(titleLabel)
        
        let leadingInstructorLabel = UILabel()
        leadingInstructorLabel.text = "Instructor"
        leadingInstructorLabel.textColor = .black
        leadingInstructorLabel.frame = CGRect(x: 15, y: 55, width: 100, height: 30)
        profileView.addSubview(leadingInstructorLabel)
        
        let trailingInstructorLabel = UILabel()
        trailingInstructorLabel.text = course.lectures[0].instructor!
        trailingInstructorLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingInstructorLabel.frame = CGRect(x: 120, y: 55, width: 300, height: 30)
        profileView.addSubview(trailingInstructorLabel)
    }
    
    func setUpClockView() {
        let clockView = UIView()
        clockView.translatesAutoresizingMaskIntoConstraints = false
        clockView.backgroundColor = .white
        
        scrollView.addSubview(clockView)
        clockView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 330).isActive = true
        clockView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        clockView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        clockView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        let clockImage = UIImageView()
        clockImage.image = UIImage(named: "clock")
        clockImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        clockImage.contentMode = .scaleAspectFit
        clockView.addSubview(clockImage)
        
        let titleLabel = UILabel()
        titleLabel.text = "Times"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        clockView.addSubview(titleLabel)
        
        let leadingTimesLabel = UILabel()
        leadingTimesLabel.text = "Times"
        leadingTimesLabel.textColor = .black
        leadingTimesLabel.frame = CGRect(x: 15, y: 55, width: 100, height: 30)
        clockView.addSubview(leadingTimesLabel)
        
        let trailingTimesLabel = UILabel()
        trailingTimesLabel.text = course.lectures[0].days! + "    " + course.lectures[0].times!
        trailingTimesLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingTimesLabel.frame = CGRect(x: 120, y: 55, width: 300, height: 30)
        clockView.addSubview(trailingTimesLabel)
    }
    
    func setUpLocationView() {
        let locationView = UIView()
        locationView.translatesAutoresizingMaskIntoConstraints = false
        locationView.backgroundColor = .white
        
        scrollView.addSubview(locationView)
        locationView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 440).isActive = true
        locationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        locationView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        let locationImage = UIImageView()
        locationImage.image = UIImage(named: "address")
        locationImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        locationImage.contentMode = .scaleAspectFit
        locationView.addSubview(locationImage)
        
        let titleLabel = UILabel()
        titleLabel.text = "Location"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        locationView.addSubview(titleLabel)
        
        let leadingLocationLabel = UILabel()
        leadingLocationLabel.text = "Location"
        leadingLocationLabel.textColor = .black
        leadingLocationLabel.frame = CGRect(x: 15, y: 55, width: 100, height: 30)
        locationView.addSubview(leadingLocationLabel)
        
        let trailingLocationLabel = UILabel()
        trailingLocationLabel.text = course.lectures[0].location!
        trailingLocationLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingLocationLabel.frame = CGRect(x: 120, y: 55, width: 300, height: 30)
        locationView.addSubview(trailingLocationLabel)
    }
    
    func setUpStatsView() {
        let statsView = UIView()
        statsView.translatesAutoresizingMaskIntoConstraints = false
        statsView.backgroundColor = .white
        
        scrollView.addSubview(statsView)
        statsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 550).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        statsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        statsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        let statsImage = UIImageView()
        statsImage.image = UIImage(named: "stats")
        statsImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        statsImage.contentMode = .scaleAspectFit
        statsView.addSubview(statsImage)
        
        let titleLabel = UILabel()
        titleLabel.text = "Seats  Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        statsView.addSubview(titleLabel)
        
        let leadingStatusLabel = UILabel()
        leadingStatusLabel.text = "Status"
        leadingStatusLabel.textColor = .black
        leadingStatusLabel.frame = CGRect(x: 15, y: 55, width: 180, height: 30)
        statsView.addSubview(leadingStatusLabel)
        
        let trailingStatusLabel = UILabel()
        if let status = course.status {
            trailingStatusLabel.text = status
        } else {
            trailingStatusLabel.text = "nil"
        }
        trailingStatusLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingStatusLabel.frame = CGRect(x: 200, y: 55, width: 100, height: 30)
        statsView.addSubview(trailingStatusLabel)
        
        let leadingSeatsAvailableLabel = UILabel()
        leadingSeatsAvailableLabel.text = "Seats_available"
        leadingSeatsAvailableLabel.textColor = .black
        leadingSeatsAvailableLabel.frame = CGRect(x: 15, y: 85, width: 180, height: 30)
        statsView.addSubview(leadingSeatsAvailableLabel)
        
        let trailingSeatsAvailableLabel = UILabel()
        if let seatsAvailable = course.seats_availible {
            trailingSeatsAvailableLabel.text = String(seatsAvailable)
        } else {
            trailingSeatsAvailableLabel.text = "nil"
        }
        trailingSeatsAvailableLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingSeatsAvailableLabel.frame = CGRect(x: 200, y: 85, width: 100, height: 30)
        statsView.addSubview(trailingSeatsAvailableLabel)
        
        let leadingWaitlistSlotsAvailableLabel = UILabel()
        leadingWaitlistSlotsAvailableLabel.text = "Waitlist_slots_available"
        leadingWaitlistSlotsAvailableLabel.textColor = .black
        leadingWaitlistSlotsAvailableLabel.frame = CGRect(x: 15, y: 115, width: 180, height: 30)
        statsView.addSubview(leadingWaitlistSlotsAvailableLabel)
        
        let trailingWaitlistSlotsAvailableLabel = UILabel()
        if let waitlistSlotsAvailable = course.seats_availible {
            trailingWaitlistSlotsAvailableLabel.text = String(waitlistSlotsAvailable)
        } else {
            trailingWaitlistSlotsAvailableLabel.text = "nil"
        }
        trailingWaitlistSlotsAvailableLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingWaitlistSlotsAvailableLabel.frame = CGRect(x: 200, y: 115, width: 300, height: 30)
        statsView.addSubview(trailingWaitlistSlotsAvailableLabel)
        
        let leadingWaitlistSlotsCapacityLabel = UILabel()
        leadingWaitlistSlotsCapacityLabel.text = "Waitlist_slots_capacity"
        leadingWaitlistSlotsCapacityLabel.textColor = .black
        leadingWaitlistSlotsCapacityLabel.frame = CGRect(x: 15, y: 145, width: 180, height: 30)
        statsView.addSubview(leadingWaitlistSlotsCapacityLabel)
        
        let trailingWaitlistSlotsCapacityLabel = UILabel()
        if let waitlistSlotsCapacity = course.seats_availible {
            trailingWaitlistSlotsCapacityLabel.text = String(waitlistSlotsCapacity)
        } else {
            trailingWaitlistSlotsCapacityLabel.text = "nil"
        }
        trailingWaitlistSlotsCapacityLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingWaitlistSlotsCapacityLabel.frame = CGRect(x: 200, y: 145, width: 300, height: 30)
        statsView.addSubview(trailingWaitlistSlotsCapacityLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
