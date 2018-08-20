//
//  Course.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/20.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import Foundation

struct Lectures: Decodable {
    let id: Int?
    let title: String?
    let days: String?
    let times: String?
    let instructor: String?
    let location: String?
    let course_id: Int?
    let created_at: String?
    let updated_at: String?
}

struct Data: Decodable {
    let id: Int?
    let crn: String?
    let course: String?
    let created_at: String?
    let updated_at: String?
    let department: String?
    let status: String?
    let campus: String?
    let units: Double?
    let seats_availible: Int?
    let waitlist_slots_availible: Int?
    let waitlist_slots_capacity: Int?
    let quarter: String?
    var lectures: [Lectures]
}

struct Courses: Decodable {
    let total: Int?
    var data: [Data]
}

struct Courses2D {
    var total: Int?
    var data: [[Data]]
}
