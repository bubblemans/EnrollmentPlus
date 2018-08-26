//
//  Data.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/26.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import Foundation

struct Data: Decodable {
    let id: Int?
    let crn: String?
    let course: String?
    let created_at: String?
    let updated_at: String?
    var department: String?
    let status: String?
    let campus: String?
    let units: Double?
    let seats_availible: Int?
    let waitlist_slots_availible: Int?
    let waitlist_slots_capacity: Int?
    let quarter: String?
    var lectures: [Lectures]
}
