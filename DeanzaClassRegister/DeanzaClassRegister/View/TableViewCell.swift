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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:  style, reuseIdentifier: reuseIdentifier)
        setupCourseInfoLabel()
    }
    
    let courseLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
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
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupCourseInfoLabel() {
        
        addSubview(courseLabel)
        addSubview(instructorLabel)
        addSubview(statusLabel)
        
        // courseLabel
//        addConstraint(NSLayoutConstraint(item: courseLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: courseLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10))
        
        // instructorLabel
//        addConstraint(NSLayoutConstraint(item: instructorLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: instructorLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 120))
        
        
        // statusLabel
//        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: .top, relatedBy: .equal, toItem: instructorLabel, attribute: .bottom, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 260))
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        if let course = course {
            courseLabel.text = course
        }
        if let instructor = instructor {
            let text = instructor
            if text.count > 12 {
                instructorLabel.text = text.components(separatedBy: " ")[1]
            } else {
                instructorLabel.text = text
            }
        }
        if let status = status {
            statusLabel.text = status
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
