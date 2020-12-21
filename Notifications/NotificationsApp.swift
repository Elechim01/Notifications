//
//  NotificationsApp.swift
//  Notifications
//
//  Created by Michele on 21/12/20.
//

import SwiftUI
import os
import CoreData

@main
struct NotificationsApp: App {
    @StateObject var notificationCenter = NotificationCenter()
    @UIApplicationDelegateAdaptor private var appDelegate : AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView(NotificationCenter: notificationCenter)
        }
    }
}
//implementiamo l'app delegate
class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
           return true
       }
       //No callback in simulator -- must use device to get valid push token
       func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           print(deviceToken)
       }
       
       func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
           print(error.localizedDescription)
       }
}
class NotificationCenter: NSObject,ObservableObject {
    var dumbData: UNNotificationResponse?
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}
extension NotificationCenter : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {}
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        dumbData = response
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {}
}



class LocalNotification: ObservableObject {
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]){(allowed,error) in
//            this callback dose not trigger on main loop be carfule
            if allowed {
                os_log(.debug,"AlloWed")
            }else{
                os_log(.debug,"Error")
            }
        }
    }
    func setLocalNotification(title : String, subtitle: String,body : String,when : Double){
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: when, repeats: false)
        let request = UNNotificationRequest.init(identifier: "localNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

extension UIApplicationDelegate{
    func application(_ application : UIApplication, didRegisterForRemoteNotificationsWithDeviceToken devicetoken : Data){
        print("Successfully registered for notifications!")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error : Error){
        print("Falied to register for notifications : \(error.localizedDescription)")
    }
}


