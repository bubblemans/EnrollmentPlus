//
//  NotiData.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2019/2/1.
//  Copyright © 2019 Alvin Lin. All rights reserved.
//

import Foundation

class NotiData: Codable {
    var course_id: Int?
    var created_at: String?
    var updated_at: String?
    
    init(course_id: Int, created_at: String, updated_at: String) {
        self.course_id = course_id
        self.created_at = created_at
        self.updated_at = updated_at
    }
}
