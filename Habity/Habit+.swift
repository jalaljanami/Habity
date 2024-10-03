//
//  Habit+.swift
//  Habity
//
//  Created by jalal on 8/7/24.
//

import Foundation
import SwiftData


//class habit2ModelView {
    @Model
    class Habit2 {
//        var id: String
        var title: String
        var color: String = "Card-1"
        var weekDays: [String] = []
        var isReminderOn: Bool = false
        var reminderText: String? = ""
        var notificationDate: Date? = Date()
        var notificationIDs: [String]?
        var createdAt: Date? = Date()
        
        init(title: String, color: String = "Card-1", weekDays: [String] = [], isReminderOn: Bool, reminderText: String? = nil, notificationDate: Date? = nil, notificationIDs: [String]? = nil, createdAt: Date? = Date()) {
//            self.id = UUID().uuidString
            self.title = title
            self.color = color
            self.weekDays = weekDays
            self.isReminderOn = isReminderOn
            self.reminderText = reminderText
            self.notificationDate = notificationDate
            self.notificationIDs = notificationIDs
            self.createdAt = createdAt
        }
    }
    

//}


