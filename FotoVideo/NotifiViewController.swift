//
//  NotifiViewController.swift
//  FotoVideo
//
//  Created by GABRIELA on 2/11/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//


import UIKit
import UserNotifications

class NotifiViewController: UIViewController, UNUserNotificationCenterDelegate {


    @IBAction func NotBu(_ sender: Any) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        content.title = "AA"
        content.body = "This is example how to create " + "AA"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        print("SE HACE")
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        content.title = "AA"
        content.body = "This is example how to create " + "AA"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        /*let content = UNMutableNotificationContent()
        content.title = "TItle"
        content.body = "I am a body"
        
        let date = Date().addingTimeInterval(5)
        
        let calendar = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from:date)
        
        let Trigger = UNCalendarNotificationTrigger(dateMatching: calendar, repeats: false)

        let uuidStr = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidStr, content: content, trigger: Trigger)
        
        center.add(request) { (error) in
            print("ERROR")
        
        }*/

        /*
        let alert = UIAlertController(title: "What's your name?", message: nil, preferredStyle: .alert)
alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

alert.addTextField(configurationHandler: { textField in
    textField.placeholder = "Input your name here..."
})

alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

    if let name = alert.textFields?.first?.text {
        print("Your name: \(name)")
    }
}))

self.present(alert, animated: true)

*/
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
