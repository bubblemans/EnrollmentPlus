//
//  TableViewCell.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/29.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var course: String?
    var instructor: String?
    var status: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:  style, reuseIdentifier: reuseIdentifier)
        setupCourseInfoLabel()
        self.backgroundColor = UIColor(red: 139, green: 3, blue: 44, alpha: 0.5)
        self.layer.borderColor = #colorLiteral(red: 0.5450980392, green: 0.01176470588, blue: 0.1725490196, alpha: 1)
        self.layer.borderWidth = 0.3
        self.backgroundColor = alphacolor
    }
    
    let courseLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = maincolor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let instructorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupCourseInfoLabel() {
        
        addSubview(courseLabel)
        addSubview(instructorLabel)
        addSubview(statusImage)
        
        // courseLabel
        addConstraint(NSLayoutConstraint(item: courseLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: courseLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10))
        courseLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        courseLabel.layer.cornerRadius = 5
        courseLabel.layer.masksToBounds = true
        
        
        // instructorLabel
        addConstraint(NSLayoutConstraint(item: instructorLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 160))
        addConstraint(NSLayoutConstraint(item: instructorLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10))
//        instructorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        // statusImage
        addConstraint(NSLayoutConstraint(item: statusImage, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -24))
        addConstraint(NSLayoutConstraint(item: statusImage, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10))
        
        self.layoutIfNeeded()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        if let course = course {
            courseLabel.text = course
        }
        if let instructor = instructor {
            let text = instructor
            if text.count > 12 {
                instructorLabel.text = text.components(separatedBy: " ")[0].count > text.components(separatedBy: " ")[1].count ? text.components(separatedBy: " ")[1]: text.components(separatedBy: " ")[0]
            } else {
                instructorLabel.text = text
            }
        }
        guard let status = status else {return}
        if status == "Open" {
            statusImage.image = UIImage(named: "open")
        } else if status == "Waitlist" {
            statusImage.image = UIImage(named: "waitlist")
        } else if status == "Full" {
            statusImage.image = UIImage(named: "full")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
