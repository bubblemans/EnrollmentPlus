//
//  BriefCourses2D.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/11/18.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import Foundation

struct BriefCourses2D: Codable {
    var total: Int?
    var data: [[BriefData]]
    var departmentList: [String]
    var isExpanded: [Bool]
}
