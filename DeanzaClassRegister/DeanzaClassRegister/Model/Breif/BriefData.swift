//
//  BriefData.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/11/18.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import Foundation

struct BriefData: Codable { 
    var id: Int?
    var crn: String?
    var course: String?
    var department: String?
    var status: String?
    var cached_lecture: Cached_lecture
}
