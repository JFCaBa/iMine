//
//  AlarmsVC.swift
//  iMine
//
//  Created by Jose Catala on 13/03/2021.
//

import UIKit

enum AlarmSwitches: String {
    case minHash = "MIN_HASHRATE_SWITCH"
}

enum AlarmValues: String {
    case minHash = "MIN_HASHRATE_VALUE"
}

class AlarmsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtMinHashrate: UITextField!
    @IBOutlet weak var switchMinHashrate: UISwitch!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func switchDidChange(_ sender: UISwitch) {
        guard let identifier = sender.restorationIdentifier else { return }
        switch identifier {
        case AlarmSwitches.minHash.rawValue:
            UserDefaults.standard.setValue(sender.isOn, forKey: AlarmSwitches.minHash.rawValue)
        default: break
        }
        UserDefaults.standard.synchronize()
    }

    // MARK: - Private
    fileprivate func setDelegates() {
        txtMinHashrate.delegate = self
    }
    
    fileprivate func setupUI() {
        if let minHashRate = UserDefaults.standard.value(forKey: AlarmValues.minHash.rawValue) as? String {
            txtMinHashrate.text = "\(minHashRate)"
        }
        if let minHashRateSwitch = UserDefaults.standard.value(forKey: AlarmSwitches.minHash.rawValue) as? Bool {
            switchMinHashrate.isOn = minHashRateSwitch
        }
    }

}

extension AlarmsVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let identifier = textField.restorationIdentifier else { return }
        switch identifier {
        case AlarmValues.minHash.rawValue:
            UserDefaults.standard.setValue(text, forKey: AlarmValues.minHash.rawValue)
        default:
            break
        }
    }
}
