//
//  Lecture.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/26.
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
