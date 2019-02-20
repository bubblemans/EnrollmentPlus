//
//  Notification.swift
//  DeanzaClassRegister
//
//  Created by Alvin Lin on 2019/2/1.
//  Copyright © 2019 Alvin Lin. All rights reserved.
//

import Foundation

class Notifications: Codable {
    var id: Int?
    var user_id: Int?
    var read: String?
    var read_at: String?
    var message: String?
    var data: NotiData?
    
    init(id: Int, user_id: Int, read: String, read_at: String, message: String, data: NotiData) {
        self.id = id
        self.user_id = user_id
        self.read = read
        self.read_at = read_at
        self.message = message
        self.data = data
    }
}
