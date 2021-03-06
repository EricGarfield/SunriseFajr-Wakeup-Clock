

import UIKit

internal class SettingsTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var placeLabel: UILabel!
    @IBOutlet private var soundDetailLabel: UILabel!
    @IBOutlet private var calculationMethodDetailLabel: UILabel!
    
    // MARK: - Other Properties
    
    private var alarm = Alarm.shared
    
    // MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupOutletsInput()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Viwes Setup
    
    private func setupOutletsInput() {
        setupSoundDetailLabel()
        calculationMethodDetailLabel.text = alarm.praytime.setting.calcMethod.description
        placeLabel.text = alarm.placeName
    }
    
    private func setupSoundDetailLabel() {
        for ringtone in Ringtones.data {
            if let soundInfo = ringtone["fileName"], soundInfo == alarm.soundPlayer.setting.ringtoneID {
                soundDetailLabel.text = ringtone["title"]
                return
            }
        }
        soundDetailLabel.text = ""
    }
    
    // MARK: - Helpers
    
    private func fetchLocation() {
        alarm.fetchLocation(withView: view, completionHandler: {
            self.setupOutletsInput()
            Alarm.shared.resetActiveAlarm {
                self.setupOutletsInput()
            }
        })
    }
    
    // MARK: - TableView Setup
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 1 {
            fetchLocation()
        }
        
        if indexPath.section == 2 && indexPath.row == 1 {
            let email = "app@saba-igc.org"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
        }
    }
}
