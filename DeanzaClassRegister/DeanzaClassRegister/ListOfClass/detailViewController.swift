//
//  detailViewController.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/23.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit
import SVProgressHUD

class detailViewController: UIViewController {
    
//    var courses: [Data] = []
//    var row = 0
//    lazy var course = courses[row]
    
    var id: Int?
    var detailData: DetailData?
    var briefData: BriefData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
//        setUpScrollView()
    }
    
    private func setupNav() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = detailData?.lectures[0].title!
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private func downloadData() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.alpha = 0.5
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            
            SVProgressHUD.show(withStatus: "Loading...")
            SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            let urlString = "https://api.daclassplanner.com/courses/" + String(id!)
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print(error)
                } else {
                    guard response != nil else { return }
                    guard data != nil else { return }
                    self.detailData = try! JSONDecoder().decode(DetailData.self, from: data!)
                    print(self.detailData!)
                }
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.setupNav()
                    self.setUpScrollView()
                    self.blackView.alpha = 0
                }
            }.resume()
        }
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
        setupDetailView()
        setUpOptionsView()
    }

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1500
        view.backgroundColor = maincolor
        return view
    }()

    func setUpInfoView() {
        let infoView = UIView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scrollView.addSubview(infoView)

        infoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 3).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 213).isActive = true
        infoView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        infoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true

        let infoImage = UIImageView()
        infoImage.image = UIImage(named: "info")
        infoImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        infoImage.contentMode = .scaleAspectFit
        infoView.addSubview(infoImage)

        let titleLabel = UILabel()
        titleLabel.text = "Course  Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        infoView.addSubview(titleLabel)

        let trailingTitleLabel = UILabel()
        trailingTitleLabel.text = detailData?.lectures[0].title!
        trailingTitleLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        
        if ((trailingTitleLabel.text?.count)!) > 60 {
            trailingTitleLabel.frame = CGRect(x: 120, y: 115, width: 250, height: 70)
            trailingTitleLabel.numberOfLines = 3
        } else if (trailingTitleLabel.text?.count)! > 35 {
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
        trailingCourseLabel.text = detailData?.course!
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
        trailingCRNLabel.text = detailData?.crn!
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
        profileView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        scrollView.addSubview(profileView)
        profileView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 220).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 107).isActive = true
        profileView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true

        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "profile")
        profileImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        profileImage.contentMode = .scaleAspectFit
        profileView.addSubview(profileImage)

        let titleLabel = UILabel()
        titleLabel.text = "Instructor  Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        profileView.addSubview(titleLabel)

        let leadingInstructorLabel = UILabel()
        leadingInstructorLabel.text = "Instructor"
        leadingInstructorLabel.textColor = .black
        leadingInstructorLabel.frame = CGRect(x: 15, y: 55, width: 100, height: 30)
        profileView.addSubview(leadingInstructorLabel)

        let trailingInstructorLabel = UILabel()
        trailingInstructorLabel.text = detailData?.lectures[0].instructor!
        trailingInstructorLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingInstructorLabel.frame = CGRect(x: 120, y: 55, width: 300, height: 30)
        profileView.addSubview(trailingInstructorLabel)
    }

    func setUpClockView() {
        let clockView = UIView()
        clockView.translatesAutoresizingMaskIntoConstraints = false
        clockView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        scrollView.addSubview(clockView)
        clockView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 330).isActive = true
        clockView.heightAnchor.constraint(equalToConstant: 107).isActive = true
        clockView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        clockView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true

        let clockImage = UIImageView()
        clockImage.image = UIImage(named: "clock")
        clockImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        clockImage.contentMode = .scaleAspectFit
        clockView.addSubview(clockImage)

        let titleLabel = UILabel()
        titleLabel.text = "Times"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        clockView.addSubview(titleLabel)

        let leadingTimesLabel = UILabel()
        leadingTimesLabel.text = "Times"
        leadingTimesLabel.textColor = .black
        leadingTimesLabel.frame = CGRect(x: 15, y: 55, width: 100, height: 30)
        clockView.addSubview(leadingTimesLabel)

        let trailingTimesLabel = UILabel()
        trailingTimesLabel.text = (detailData?.lectures[0].days)! + "    " + (detailData?.lectures[0].times)!
        trailingTimesLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingTimesLabel.frame = CGRect(x: 120, y: 55, width: 300, height: 30)
        clockView.addSubview(trailingTimesLabel)
    }

    func setUpLocationView() {
        let locationView = UIView()
        locationView.translatesAutoresizingMaskIntoConstraints = false
        locationView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        scrollView.addSubview(locationView)
        locationView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 440).isActive = true
        locationView.heightAnchor.constraint(equalToConstant: 107).isActive = true
        locationView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        locationView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true

        let locationImage = UIImageView()
        locationImage.image = UIImage(named: "address")
        locationImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        locationImage.contentMode = .scaleAspectFit
        locationView.addSubview(locationImage)

        let titleLabel = UILabel()
        titleLabel.text = "Location"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        locationView.addSubview(titleLabel)

        let leadingLocationLabel = UILabel()
        leadingLocationLabel.text = "Location"
        leadingLocationLabel.textColor = .black
        leadingLocationLabel.frame = CGRect(x: 15, y: 55, width: 100, height: 30)
        locationView.addSubview(leadingLocationLabel)

        let trailingLocationLabel = UILabel()
        trailingLocationLabel.text = detailData?.lectures[0].location!
        trailingLocationLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingLocationLabel.frame = CGRect(x: 120, y: 55, width: 300, height: 30)
        locationView.addSubview(trailingLocationLabel)
    }

    func setUpStatsView() {
        let statsView = UIView()
        statsView.translatesAutoresizingMaskIntoConstraints = false
        statsView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        scrollView.addSubview(statsView)
        statsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 550).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: 197).isActive = true
        statsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        statsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true

        let statsImage = UIImageView()
        statsImage.image = UIImage(named: "stats")
        statsImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        statsImage.contentMode = .scaleAspectFit
        statsView.addSubview(statsImage)

        let titleLabel = UILabel()
        titleLabel.text = "Seats  Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        statsView.addSubview(titleLabel)

        let leadingStatusLabel = UILabel()
        leadingStatusLabel.text = "Status"
        leadingStatusLabel.textColor = .black
        leadingStatusLabel.frame = CGRect(x: 15, y: 55, width: 180, height: 30)
        statsView.addSubview(leadingStatusLabel)

        let trailingStatusLabel = UILabel()
        if let status = detailData?.status {
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
        if let seatsAvailable = detailData?.seats_available {
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
        if let waitlistSlotsAvailable = detailData?.waitlist_slots_available{
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
        if let waitlistSlotsCapacity = detailData?.waitlist_slots_capacity {
            trailingWaitlistSlotsCapacityLabel.text = String(waitlistSlotsCapacity)
        } else {
            trailingWaitlistSlotsCapacityLabel.text = "nil"
        }
        trailingWaitlistSlotsCapacityLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingWaitlistSlotsCapacityLabel.frame = CGRect(x: 200, y: 145, width: 300, height: 30)
        statsView.addSubview(trailingWaitlistSlotsCapacityLabel)
    }
    
    private func  setupDetailView() {
        let detailView = UIView()
        detailView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(detailView)
        detailView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 750).isActive = true
        detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 667).isActive = true
        detailView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let infoImage = UIImageView()
        infoImage.image = UIImage(named: "detail")
        infoImage.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
        infoImage.contentMode = .scaleAspectFit
        detailView.addSubview(infoImage)
        
        let titleLabel = UILabel()
        titleLabel.text = "Detail  Info"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.frame = CGRect(x: 60, y: 10, width: 300, height: 40)
        detailView.addSubview(titleLabel)
        
        let leadingQuarterLabel = UILabel()
        leadingQuarterLabel.text = "Quarter"
        leadingQuarterLabel.textColor = .black
        leadingQuarterLabel.frame = CGRect(x: 15, y: 55, width: 180, height: 30)
        detailView.addSubview(leadingQuarterLabel)
        
        let trailingQuarterLabel = UILabel()
        if let quarter = detailData?.quarter {
            trailingQuarterLabel.text = quarter
        } else {
            trailingQuarterLabel.text = "nil"
        }
        trailingQuarterLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingQuarterLabel.frame = CGRect(x: 200, y: 55, width: 100, height: 30)
        detailView.addSubview(trailingQuarterLabel)
        
        let leadingDescriptionLabel = UILabel()
        leadingDescriptionLabel.text = "Description"
        leadingDescriptionLabel.textColor = .black
        leadingDescriptionLabel.frame = CGRect(x: 15, y: 85, width: 180, height: 30)
        detailView.addSubview(leadingDescriptionLabel)
        
        let trailingDescriptionLabel = UILabel()
        if let quarter = detailData?.description {
            trailingDescriptionLabel.text = quarter
        } else {
            trailingDescriptionLabel.text = "nil"
        }
        trailingDescriptionLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingDescriptionLabel.numberOfLines = 6
        trailingDescriptionLabel.frame = CGRect(x: 35, y: 115, width: 350, height: 120)
        detailView.addSubview(trailingDescriptionLabel)
        
        let leadingMaterialLabel = UILabel()
        leadingMaterialLabel.text = "Material"
        leadingMaterialLabel.textColor = .black
        leadingMaterialLabel.frame = CGRect(x: 15, y: 235, width: 180, height: 30)
        detailView.addSubview(leadingMaterialLabel)
        
        let trailingMaterialLabel = UILabel()
        if let material = detailData?.class_material {
            trailingMaterialLabel.text = String(material)
        } else {
            trailingMaterialLabel.text = "nil"
        }
        trailingMaterialLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingMaterialLabel.numberOfLines = 4
        trailingMaterialLabel.frame = CGRect(x: 35, y: 265, width: 350, height: 90)
        detailView.addSubview(trailingMaterialLabel)
        
        let leadingPrerequisitesNoteLabel = UILabel()
        leadingPrerequisitesNoteLabel.text = "Prerequisites Note"
        leadingPrerequisitesNoteLabel.textColor = .black
        leadingPrerequisitesNoteLabel.frame = CGRect(x: 15, y: 355, width: 180, height: 30)
        detailView.addSubview(leadingPrerequisitesNoteLabel)
        
        let trailingPrerequisitesNoteLabel = UILabel()
        guard let prerequisitesNote = detailData?.prerequisites_note else { return }
        if prerequisitesNote.count != 0 {
             trailingPrerequisitesNoteLabel.text = String(prerequisitesNote)
        } else {
            trailingPrerequisitesNoteLabel.text = "nil"
        }
        trailingPrerequisitesNoteLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingPrerequisitesNoteLabel.numberOfLines = 3
        trailingPrerequisitesNoteLabel.frame = CGRect(x: 35, y: 385, width: 350, height: 120)
        detailView.addSubview(trailingPrerequisitesNoteLabel)
        
        let leadingPrerequisiteLabel = UILabel()
        leadingPrerequisiteLabel.text = "Prerequisite"
        leadingPrerequisiteLabel.textColor = .black
        leadingPrerequisiteLabel.frame = CGRect(x: 15, y: 505, width: 180, height: 30)
        detailView.addSubview(leadingPrerequisiteLabel)
        
        let trailingPrerequisiteLabel = UILabel()
        guard let prerequisite = detailData?.prerequisites_advisory else { return }
        if prerequisitesNote.count != 0 {
            trailingPrerequisiteLabel.text = String(prerequisite)
        } else {
            trailingPrerequisiteLabel.text = "nil"
        }
        trailingPrerequisiteLabel.textColor = #colorLiteral(red: 0.3921892404, green: 0.3921892404, blue: 0.3921892404, alpha: 1)
        trailingPrerequisiteLabel.numberOfLines = 3
        trailingPrerequisiteLabel.frame = CGRect(x: 35, y: 535, width: 250, height: 120)
        detailView.addSubview(trailingPrerequisiteLabel)
    }

    let subscribeButton: UIButton = {
        let bt = UIButton()

        bt.layer.cornerRadius = 20
//        bt.layer.borderWidth = 2

        let subcribeImage = UIImage(named: "subscribe")?.withRenderingMode(.alwaysTemplate)
        bt.setImage(subcribeImage, for: UIControl.State())

        bt.addTarget(self, action: #selector(handleSubscribe), for: .touchUpInside)
        return bt
    }()

    let planButton: UIButton = {
        let bt = UIButton()

        bt.layer.cornerRadius = 20
//        bt.layer.borderWidth = 2

        let planImage = UIImage(named: "calendar")?.withRenderingMode(.alwaysTemplate)
        bt.setImage(planImage, for: UIControl.State())

        bt.addTarget(self, action: #selector(handlePlan), for: .touchUpInside)
        return bt
    }()

    let favoriteButton: UIButton = {
        let bt = UIButton()

        bt.layer.cornerRadius = 20
//        bt.layer.borderWidth = 2

        let favoriteImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        bt.setImage(favoriteImage, for: UIControl.State())

        bt.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return bt
    }()

    func setUpOptionsView() {

        // optionsView
        let optionsView = UIView()
        optionsView.translatesAutoresizingMaskIntoConstraints = false
        optionsView.backgroundColor = .white

        scrollView.addSubview(optionsView)
        optionsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1420).isActive = true
        optionsView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        optionsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true

        // subcribeButton
        optionsView.addSubview(subscribeButton)
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        optionsView.addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .centerY, relatedBy: .equal, toItem: optionsView, attribute: .centerY, multiplier: 1, constant: 0))
        optionsView.addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .leading, relatedBy: .equal, toItem: optionsView, attribute: .leading, multiplier: 1, constant: 5))
        optionsView.addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140))
        optionsView.addConstraint(NSLayoutConstraint(item: subscribeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))

        let controller = TableViewController()
        subscribeButton.isSelected = controller.containData(at: detailData?.id, from: subscribeList) != -1
//        subscribeButton.tintColor = subscribeButton.isSelected ? .white : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        subscribeButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

//        var titleColor: UIColor = subscribeButton.isSelected ? .white : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        var titleColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        var title = subscribeButton.isSelected ? "Subscribing" : "Subscribe"
        subscribeButton.setTitle(title, for: UIControl.State())
        subscribeButton.setTitleColor(titleColor, for: UIControl.State())

//        subscribeButton.layer.borderColor = subscribeButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        subscribeButton.backgroundColor = subscribeButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        // planButton
        optionsView.addSubview(planButton)
        planButton.translatesAutoresizingMaskIntoConstraints = false
        optionsView.addConstraint(NSLayoutConstraint(item: planButton, attribute: .centerY, relatedBy: .equal, toItem: optionsView, attribute: .centerY, multiplier: 1, constant: 0))
        optionsView.addConstraint(NSLayoutConstraint(item: planButton, attribute: .leading, relatedBy: .equal, toItem: subscribeButton, attribute: .trailing, multiplier: 1, constant: 15))
        optionsView.addConstraint(NSLayoutConstraint(item: planButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
        optionsView.addConstraint(NSLayoutConstraint(item: planButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))

        planButton.isSelected = controller.containData(at: detailData?.id, from: planList) != -1
        planButton.tintColor = planButton.isSelected ? .white : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        planButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        titleColor = planButton.isSelected ? .white : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        title = planButton.isSelected ? "Planned" : "Plan"
        planButton.setTitle(title, for: UIControl.State())
//        planButton.setTitleColor(titleColor, for: UIControl.State())
        planButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State())

        planButton.layer.borderColor = planButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        planButton.backgroundColor = planButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        planButton.backgroundColor = planButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        // favoriteButton
        optionsView.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        optionsView.addConstraint(NSLayoutConstraint(item: favoriteButton, attribute: .centerY, relatedBy: .equal, toItem: optionsView, attribute: .centerY, multiplier: 1, constant: 0))
        optionsView.addConstraint(NSLayoutConstraint(item: favoriteButton, attribute: .leading, relatedBy: .equal, toItem: planButton, attribute: .trailing, multiplier: 1, constant: 15))
        optionsView.addConstraint(NSLayoutConstraint(item: favoriteButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 95))
        optionsView.addConstraint(NSLayoutConstraint(item: favoriteButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))

        favoriteButton.isSelected = controller.containData(at: detailData?.id, from: favoriteList) != -1
//        favoriteButton.tintColor = favoriteButton.isSelected ? .white : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        favoriteButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        titleColor = favoriteButton.isSelected ? .white : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        title = favoriteButton.isSelected ? "Liked" : "Like"
        favoriteButton.setTitle(title, for: UIControl.State())
        favoriteButton.setTitleColor(titleColor, for: UIControl.State())
        favoriteButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State())

        favoriteButton.layer.borderColor = favoriteButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        favoriteButton.backgroundColor = favoriteButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        favoriteButton.backgroundColor = favoriteButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)


    }

    @objc func handleSubscribe() {

        let controller = TableViewController()
        controller.updateDataList(at: briefData!, with: &subscribeList)

        subscribeButton.isSelected  = !subscribeButton.isSelected

//        let tintColor: UIColor = subscribeButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        subscribeButton.tintColor = tintColor
        subscribeButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        

        let textColor: UIColor = subscribeButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
        subscribeButton.setTitleColor(textColor, for: UIControl.State())
        subscribeButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State())

        subscribeButton.layer.borderColor = subscribeButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        subscribeButton.backgroundColor = subscribeButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subscribeButton.backgroundColor = subscribeButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        let title = subscribeButton.isSelected ? "Subscribing" : "Subscribe"
        subscribeButton.setTitle(title, for: UIControl.State())
    }

    @objc func handlePlan() {
        let controller = TableViewController()
//        controller.updateDataList(at: briefData!, with: &planList)
//        controller.updataCalendarList(at: briefData!)
//        controller.postSubscribe(data: briefData, type:
        if let data = briefData {
            controller.handleCalendar(data: data)
        }
        postNotiCalendar()
        
        planButton.isSelected  = !planButton.isSelected

//        let tintColor: UIColor = planButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        planButton.tintColor = tintColor
        planButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

//        let textColor: UIColor = planButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        planButton.setTitleColor(textColor, for: UIControl.State())
        planButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State())

        planButton.layer.borderColor = planButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        planButton.backgroundColor = planButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        planButton.backgroundColor = planButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        let title = planButton.isSelected ? "Planned" : "Plan"
        planButton.setTitle(title, for: UIControl.State())
    }

    @objc func handleFavorite() {
        let controller = TableViewController()
        controller.updateDataList(at: briefData!, with: &favoriteList)
//        postNotiCalendar()

        favoriteButton.isSelected  = !favoriteButton.isSelected

//        let tintColor: UIColor = favoriteButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        favoriteButton.tintColor = tintColor
        favoriteButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

//        let textColor: UIColor = favoriteButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        favoriteButton.setTitleColor(textColor, for: UIControl.State())
        favoriteButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State())

        favoriteButton.layer.borderColor = favoriteButton.isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1)
//        favoriteButton.backgroundColor = favoriteButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        favoriteButton.backgroundColor = favoriteButton.isSelected ? #colorLiteral(red: 0.9411764706, green: 0.7607843137, blue: 0.1882352941, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        let title = favoriteButton.isSelected ? "Liked" : "Like"
        favoriteButton.setTitle(title, for: UIControl.State())
    }
    
    private func postNotiCalendar() {
        let detailVCUpdate = Notification.Name("detailVCUpdate")
        NotificationCenter.default.post(name: detailVCUpdate, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
