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
        var title: String
        var color: String?
        var weekDays: [String]?
        var isReminderOn: Bool
        var reminderText: String?
        var notificationDate: Date?
        var notificationIDs: [String]?
        
        init(title: String, color: String? = nil, weekDays: [String]? = nil, isReminderOn: Bool, reminderText: String? = nil, notificationDate: Date? = nil, notificationIDs: [String]? = nil) {
            self.title = title
            self.color = color
            self.weekDays = weekDays
            self.isReminderOn = isReminderOn
            self.reminderText = reminderText
            self.notificationDate = notificationDate
            self.notificationIDs = notificationIDs
        }
    }
    

//}


