//
//  AppDelegate.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadStorageData {
            self.registerForPushNotifications()
            self.checkForPermission()
        }
        return true
    }
    
    func loadStorageData(completion: @escaping () -> Void) {
        Task {
            await Container.shared.container_load()
            completion()
        }
    }
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.dispatchNotification()
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission denied: \(error.localizedDescription)")
            }
        }
    }
    
    func chooseRandom() -> WordItem? {
        
        let count = Container.shared.get_length()
        let index = Int.random(in: 0...count-1)
        let rand_word = Container.shared.get_word(index: index)
        
        return rand_word
    }
    
    func dispatchNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        for h in 9...18 {
            let word = chooseRandom()
            let title = word?.word ?? "bebeb"
            let body = word?.description ?? ".cpp"
            
            var dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current)
            dateComponents.hour = h
            dateComponents.minute = 0
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "notification_\(h)", content: content, trigger: trigger)
            notificationCenter.add(request) { error in
                if let error = error {
                    print("Failed to add notification request: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
