//
//  Data.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/26.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import Foundation

struct Data: Decodable {
    var id: Int?
    var crn: String?
    var course: String?
    var created_at: String?
    var updated_at: String?
    var department: String?
    var status: String?
    var campus: String?
    var units: Double?
    var seats_available: Int?
    var waitlist_slots_available: Int?
    var waitlist_slots_capacity: Int?
    var quarter: String?
    var lectures: [Lectures]
}
