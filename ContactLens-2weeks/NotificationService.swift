//
//  Notification.swift
//  ContactLens-2weeks
//
//  Created by Fujii Ryosuke on R 6/06/08.
//

import UserNotifications

class NotificationService {
    private let userDefaultsKey = "scheduledNotificationDate"

    func scheduleNotification(for date: Date) -> Date? {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Two weeks have passed since the specified date."
        content.sound = UNNotificationSound.default

        // 2週間後の日付を計算
        guard let twoWeeksLater = Calendar.current.date(byAdding: .day, value: 14, to: date) else { return nil }
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: twoWeeksLater)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for two weeks later.")
            }
        }

        // スケジュールした日付を保存
        UserDefaults.standard.set(twoWeeksLater, forKey: userDefaultsKey)

        return twoWeeksLater
    }

    func getScheduledNotificationDate() -> Date? {
        return UserDefaults.standard.object(forKey: userDefaultsKey) as? Date
    }
}
