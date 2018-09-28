

import UIKit
import UserNotifications

internal class NotificationErrorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func onTapTryAgainButton(sender: UIButton) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            (isPermissionGranted, error) in
            if isPermissionGranted && error == nil {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                let settingsURL = URL(string: "App-Prefs:root")
                if let url = settingsURL {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
}
