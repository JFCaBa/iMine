//
//  Dashboard.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

class DashboardVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var lblReported: UILabel!
    @IBOutlet weak var btnUserSettings: UIBarButtonItem!
    @IBOutlet weak var btnReload: UIBarButtonItem!
    @IBOutlet weak var imgCurrent: UIImageView!
    @IBOutlet weak var imgAverage: UIImageView!
    @IBOutlet weak var imgReported: UIImageView!
    @IBOutlet weak var stackCurrent: UIStackView!
    @IBOutlet weak var stackAverage: UIStackView!
    @IBOutlet weak var stackReported: UIStackView!
    // MARK: - Ivars
    
    // MARK: - ViewModels
    public var viewModel = DashboardVM()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(shouldFetchData), name: NSNotification.Name(rawValue: UserDefaults.keys.fetchData), object: nil)
        setupUI()
        loadData()
    }

    // MARK: - Notifications
    @objc func shouldFetchData() {
        loadData(spinner: false)
    }
    
    // MARK: - Actions
    @IBAction func didTapOnReloadData(_ sender: UIBarButtonItem) {
        loadData()
    }
    
    @IBAction func didTapOnUserSettings(_ sender: UIBarButtonItem) {
        openUserSettings(sender)
    }
    
    // MARK: - Private
    private func setupUI() {
        stackCurrent.layer.cornerRadius = 15
        stackCurrent.layer.masksToBounds = true
        stackCurrent.layer.borderWidth = 1
        stackCurrent.layer.borderColor = UIColor.darkGray.cgColor
        
        stackAverage.layer.cornerRadius = 15
        stackAverage.layer.masksToBounds = true
        stackAverage.layer.borderWidth = 1
        stackAverage.layer.borderColor = UIColor.darkGray.cgColor
        
        stackReported.layer.cornerRadius = 15
        stackReported.layer.masksToBounds = true
        stackReported.layer.borderWidth = 1
        stackReported.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    private func populateData() {
        // Labels
        lblCurrent.text  = viewModel.current
        lblAverage.text  = viewModel.average
        lblReported.text = viewModel.reported
        // Images
        imgCurrent.image      = viewModel.currentImage
        imgCurrent.tintColor  = viewModel.currentImageTintColor
        imgReported.image     = viewModel.reportedImage
        imgReported.tintColor = viewModel.reportedImageTintColor
        imgAverage.image      = viewModel.averageImage
        imgAverage.tintColor  = viewModel.averageImageTintColor
    }
    
    private func loadData(spinner: Bool = true) {
        guard let wallet = UserDefaults.standard.value(forKey: UserDefaults.keys.wallet) as? String else {
            openUserSettings(btnUserSettings)
            return
        }
        // The viewModel needs the wallet to fetch the pool data
        viewModel.wallet = wallet
        
        // Dont allow the user to reload the data and abuse of this service
        if viewModel.canFetchData == false { return }
        
        // Use dispatch group to link the two async calls
        let group = DispatchGroup()
        
        // Fetch the data
        if spinner {
            showIndicator()
        }
        
        // Status
        group.enter()
        viewModel.getStatus {  [weak self] error, status in
            if let error = error {
                print(error)
                self?.showError(error.localizedDescription)
            }
            else if let status = status {
                self?.viewModel.currentStatus = status
            }
            group.leave()
        }
        
        // ETH price
        group.enter()
        viewModel.getETHPrice { [weak self] error, value in
            if let error = error {
                print(error)
                self?.showError(error.localizedDescription)
            }
            else if let value = value {
                self?.viewModel.ethValue = value
            }
            group.leave()
        }
        
        // API calls did finish, do the tasks in common
        group.notify(queue: .main) {
            self.hideIndicator()
            self.populateData()
        }
    }
}

