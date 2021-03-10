//
//  Summary.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

class Summary: UIViewController {
    // MARK: - Outlets
    // MARK: - Ivars
    // MARK: - ViewModels
    var viewModel = DashboardVM()
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get the previous fetched data from the Dashboard controller
        if let dashboard = tabBarController?.viewControllers?[0] as? Dashboard {
            viewModel = dashboard.viewModel
        }
    }
    
    // MARK: - Actions
    @IBAction func didTapOnUserSettings(_ sender: UIBarButtonItem) {
        openUserSettings(sender)
    }
    
    // MARK: - Private
    private func setupUI() {
        
    }
    
    private func populateData() {
        
    }

}
