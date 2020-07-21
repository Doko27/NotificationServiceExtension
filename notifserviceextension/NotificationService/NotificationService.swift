//
//  NotificationService.swift
//  NotificationService
//
//  Created by IRFAN TRIHANDOKO on 20/07/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    var notifData: [Any] = []

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [Modified]"
            let data = bestAttemptContent.userInfo as NSDictionary
            // Save notification data to UserDefaults
//            let pref = UserDefaults.init(suiteName: "group.id.gits.notifserviceextension")
//            self.notifData = pref?.array(forKey: "NOTIF_DATA") ?? []
//            self.notifData.append(data)
//            pref?.set(self.notifData, forKey: "NOTIF_DATA")
//            pref?.synchronize()
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
