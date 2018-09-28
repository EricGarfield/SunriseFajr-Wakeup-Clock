

import UIKit
import UserNotifications

internal class WelcomeViewController: UIViewController {
    
    @IBOutlet private var allowNotificationButton: UIButton!
    
    internal var successHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allowNotificationButton.layer.masksToBounds = true
        allowNotificationButton.layer.cornerRadius = 20
    }
    
    @IBAction private func onButtonTap(sender: UIButton) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            (isPermissionGranted, error) in
            if isPermissionGranted && error == nil {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    self.successHandler?()
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
