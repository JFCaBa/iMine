//
//  Dashboard.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

class Dashboard: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var lblReported: UILabel!
    // MARK: - Ivars
    
    // MARK: - ViewModels
    var viewModel = DashboardVM()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - Actions
    @IBAction func didTapOnReloadData(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func didTapOnUserSettings(_ sender: UIBarButtonItem) {
        openUserSettings(sender)
    }
    
    // MARK: - Private
    private func setupUI() {
        
    }
    
    private func populateData() {
        
    }
    
    private func loadData() {
        if viewModel.canFetchData == false { return }
        // Fetch the data
        showIndicator()
        viewModel.getStatus {  [weak self] error, status in
            self?.hideIndicator()
            if let error = error {
                print(error)
                self?.showError(error.localizedDescription)
            }
            else {
                self?.viewModel.currentStatus = status
                self?.populateData()
            }
        }
    }
}

