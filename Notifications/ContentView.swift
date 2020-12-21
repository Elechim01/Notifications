//
//  ContentView.swift
//  Notifications
//
//  Created by Michele on 21/12/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var localNotification = LocalNotification()
    @ObservedObject var NotificationCenter : NotificationCenter
    var body: some View {
        VStack{
            Button("Notifiche in background  Notification"){
                localNotification.setLocalNotification(title: "Notifica", subtitle: "Prova", body: "questo è un test", when: 5)
            }
            if let dumbData = NotificationCenter.dumbData{
                Text("Old Notification Payload:")
                Text(dumbData.actionIdentifier)
                Text(dumbData.notification.request.content.body)
                Text(dumbData.notification.request.content.title)
                Text(dumbData.notification.request.content.subtitle)
            }
//            Button ("local Notification"){
//
//
//
//
//                let content = UNMutableNotificationContent()
//                                content.title = "Notification Tutorial"
//                                content.subtitle = "from ioscreator.com"
//                                content.body = " Notification triggered"
//                                content.sound = UNNotificationSound.default
//                let imageName = "applelogo"
//                guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else{return}
//
//                            let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
//
//                            content.attachments = [attachment]
//
//                            // 4.
//                           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                           let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
//
//                           // 5.
//                UNUserNotificationCenter.current().add(request)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( NotificationCenter: NotificationCenter())
    }
}
