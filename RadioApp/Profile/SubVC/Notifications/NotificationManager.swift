//
//  NotificationManager.swift
//  RadioApp
//
//  Created by Иван Семенов on 09.08.2024.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    // MARK: - Singleton
    static let shared = NotificationManager()
    
    private init() { }
    
    // MARK: - Public Methods
    func requestNotificationPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Разрешение предоставлено")
            } else {
                print("Permission denied: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification."
        
        ///тест
        var dateComponents = DateComponents()
        dateComponents.second = 10
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Уведомление запланировано")
            }
        }
    }
    
    func cancelNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        print("Все уведомления отменены")
    }
    
    func notificationsAreEnabled() -> Bool {
        let notificationCenter = UNUserNotificationCenter.current()
        var notificationsEnabled = false
        let semaphore = DispatchSemaphore(value: 0)
        notificationCenter.getNotificationSettings { settings in
            notificationsEnabled = settings.authorizationStatus == .authorized
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
        return notificationsEnabled
    }
}

