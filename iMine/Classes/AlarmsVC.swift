//
//  AlarmsVC.swift
//  iMine
//
//  Created by Jose Catala on 13/03/2021.
//

import UIKit

enum AlarmSwitches: String {
    case minHash = "MIN_HASHRATE_SWITCH"
    case minEarnings = "MIN_EARNINGS_SWITCH"
    case maxEarnings = "MAX_EARNINGS_SWITCH"
    case maxUnpaid = "MAX_UNPAID_SWITCH"
    case maxFanSpeed = "MAX_FAN_SPEED_SWITCH"
    case maxTemp = "MAX_TEMP_SWITCH"
}

enum AlarmValues: String {
    case minHash = "MIN_HASHRATE_VALUE"
    case minEarnings = "MIN_EARNINGS_VALUE"
    case maxEarnings = "MAX_EARNINGS_VALUE"
    case maxUnpaid = "MAX_UNPAID_VALUE"
    case maxFanSpeed = "MAX_FAN_SPEED_VALUE"
    case maxTemp = "MAX_TEMP_VALUE"
}

class AlarmsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtMinHashrate: UITextField!
    @IBOutlet weak var txtMinEarnings: UITextField!
    @IBOutlet weak var txtMaxEarnings: UITextField!
    @IBOutlet weak var txtMaxUnpaid: UITextField!
    @IBOutlet weak var txtMaxFanSpeed: UITextField!
    @IBOutlet weak var txtMaxTemp: UITextField!
    
    @IBOutlet weak var switchMinHashrate: UISwitch!
    @IBOutlet weak var switchMinEarnings: UISwitch!
    @IBOutlet weak var switchMaxEarnings: UISwitch!
    @IBOutlet weak var switchMaxUpaid: UISwitch!
    @IBOutlet weak var switchMaxFanSpeed: UISwitch!
    @IBOutlet weak var switchMaxTemp: UISwitch!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func switchDidChange(_ sender: UISwitch) {
        guard let identifier = sender.restorationIdentifier else { return }
        UserDefaults.standard.setValue(sender.isOn, forKey: identifier)
        UserDefaults.standard.synchronize()
    }

    // MARK: - Private
    fileprivate func setDelegates() {
        txtMinHashrate.delegate = self
        txtMinEarnings.delegate = self
        txtMaxEarnings.delegate = self
        txtMaxUnpaid.delegate   = self
        txtMaxFanSpeed.delegate = self
        txtMaxTemp.delegate     = self
    }
    
    fileprivate func setupUI() {
        // Hash
        if let minHashRate = UserDefaults.standard.value(forKey: AlarmValues.minHash.rawValue) as? String {
            txtMinHashrate.text = "\(minHashRate)"
        }
        if let minHashRateSwitch = UserDefaults.standard.value(forKey: AlarmSwitches.minHash.rawValue) as? Bool {
            switchMinHashrate.isOn = minHashRateSwitch
        }
        // Min earnings
        if let minEarnings = UserDefaults.standard.value(forKey: AlarmValues.minEarnings.rawValue) as? String {
            txtMinEarnings.text = "\(minEarnings)"
        }
        if let minEarningsSwitch = UserDefaults.standard.value(forKey: AlarmSwitches.minEarnings.rawValue) as? Bool {
            switchMinEarnings.isOn = minEarningsSwitch
        }
        // Max earnings
        if let maxEarnings = UserDefaults.standard.value(forKey: AlarmValues.maxEarnings.rawValue) as? String {
            txtMaxEarnings.text = "\(maxEarnings)"
        }
        if let maxEarningsSwitch = UserDefaults.standard.value(forKey: AlarmSwitches.maxEarnings.rawValue) as? Bool {
            switchMaxEarnings.isOn = maxEarningsSwitch
        }
        // Unpaid
        if let unpaid = UserDefaults.standard.value(forKey: AlarmValues.maxUnpaid.rawValue) as? String {
            txtMaxUnpaid.text = "\(unpaid)"
        }
        if let unpaidSwitch = UserDefaults.standard.value(forKey: AlarmSwitches.maxUnpaid.rawValue) as? Bool {
            switchMaxUpaid.isOn = unpaidSwitch
        }
        // Fan speed
        if let maxFanSpeed = UserDefaults.standard.value(forKey: AlarmValues.maxFanSpeed.rawValue) as? String {
            txtMaxFanSpeed.text = "\(maxFanSpeed)"
        }
        if let maxFanSpeedSwitch = UserDefaults.standard.value(forKey: AlarmSwitches.maxFanSpeed.rawValue) as? Bool {
            switchMaxFanSpeed.isOn = maxFanSpeedSwitch
        }
        // Temp
        if let maxTemp = UserDefaults.standard.value(forKey: AlarmValues.maxTemp.rawValue) as? String {
            txtMaxTemp.text = "\(maxTemp)"
        }
        if let maxTempSwitch = UserDefaults.standard.value(forKey: AlarmSwitches.maxTemp.rawValue) as? Bool {
            switchMaxTemp.isOn = maxTempSwitch
        }
    }

}

extension AlarmsVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let identifier = textField.restorationIdentifier else { return }
        UserDefaults.standard.setValue(text, forKey: identifier)
        UserDefaults.standard.synchronize()
    }
}
