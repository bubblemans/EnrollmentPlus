//
//  Courses.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2018/8/26.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import Foundation

struct Courses: Decodable {
    var total: Int?
    var data: [DetailData]
}
