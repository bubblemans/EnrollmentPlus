//
//  Lecture.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/26.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import Foundation

struct Lectures: Decodable {
    var id: Int?
    var title: String?
    var days: String?
    var times: String?
    var instructor: String?
    var location: String?
    var course_id: Int?
    var created_at: String?
    var updated_at: String?
}
