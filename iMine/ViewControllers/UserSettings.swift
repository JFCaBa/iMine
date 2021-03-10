//
//  UserSettings.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

class UserSettings: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtWallet: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    // MARK: - ViewModel
    var viewModel = UserSettingsVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func didTapOnSave(_ sender: UIButton) {
        view.endEditing(true)
        if viewModel.isValidWalletAddress() {
            UserDefaults.standard.setValue(viewModel.wallet, forKey: UserDefaults.keys.wallet)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: - Private
    private func setupDelegates() {
        txtWallet.delegate = self
    }
    
    private func setupUI() {
        
    }
}

extension UserSettings: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard  let text = textField.text else {
            return
        }
        viewModel.wallet = text
    }
}
