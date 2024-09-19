//
//  HabitViewModel.swift
//  Habity
//
//  Created by jalal on 7/28/24.
//

import SwiftUI
import CoreData
import UserNotifications

class HabitViewModel: ObservableObject {
    
    // MARK: New Habit Properties

    @Published var addNewHabit: Bool = false
    
    @Published var title: String = ""
    @Published var color: String = "Card-1"
    @Published var weekDays: [String] = []
    @Published var isReminderOn: Bool = false
    @Published var reminderText: String = ""
    @Published var reminderDate: Date = Date()
    
    // MARK: Reminder Time Picker
    @Published var showTimePicker: Bool = false
    
    // MARK: Adding Habit to Database
    func addHabit(context: NSManagedObjectContext) async -> Bool {
        
//        let habit = HabitTracker(context: context)
//        habit.title = title
//        habit.color = color
//        habit.weekDays = weekDays
//        habit.isReminderOn = isReminderOn
//        habit.reminderText = reminderText
//        habit.notificationDate = reminderDate
//        habit.notificationIDs = []
//        
//        if isReminderOn {
//            // MARK: Scheduling Notification
//            if let ids = try? await scheduleNotification() {
//                habit.notificationIDs = ids
//                if let _ = try? context.save() {
//                    return true
//                }
//            }
//        } else {
//            // MARK: Adding Data
//            do {
//                if let _ = try? context.save() {
//                    return true
//                }
//            } catch {
//                print("EEEEEEEror")
//            }
//        }
        return false
    }
    
    // MARK: Adding Notifications
    func scheduleNotification() async -> [String] {
        let content = UNMutableNotificationContent()
        
        content.title = "Habit Reminder"
        content.subtitle = reminderText
        content.sound = UNNotificationSound.default
        
        // Scheduled Ids
        var notificationsIDs: [String] = []
        let calendar = Calendar.current
        let weekdaySymbols: [String] = calendar.weekdaySymbols
        
        // MARK: Scheduling Notification
        for weekDay in weekDays {
            // UNIQUE ID FOR EACH NOTIFICATION
            let id = UUID().uuidString
            let hour = calendar.component(.hour, from: reminderDate)
            let min = calendar.component(.minute, from: reminderDate)
            let day = weekdaySymbols.firstIndex { currentDay in
                return currentDay == weekDay
            } ?? -1
            // MARK: Since Week Day Starts from 1-7
            // Thus Adding +1 to Index
            
            if day != -1 {
                var components = DateComponents()
                components.hour = hour
                components.minute = min
                components.weekday = day + 1
                
                // MARK: Thus Rhis Will Trigger Notification on Each Selected Day
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                
                // MARK: Notification Request
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                try? await UNUserNotificationCenter.current().add(request)
                
                // MARK: Adding ID
                notificationsIDs.append(id)
            }
        }
        
        return notificationsIDs
    }
    
    // MARK: Erasing Contex
    func resetData() {
        title = ""
        color = "Card-1"
        weekDays = []
        isReminderOn = false
        reminderText = ""
        reminderDate = Date()
    }
    
    // MARK: Done Button Status
    func doneStatus() -> Bool {
        let reminderStatus = isReminderOn ? reminderText == "" : false
        
        if title == "" || weekDays.isEmpty || reminderStatus {
            return false
        }
        return true
    }
}
