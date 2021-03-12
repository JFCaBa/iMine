//
//  Reports.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

class ReportsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var container: UIView!
    // MARK: - Ivars
    // MARK: - ViewModels
    var viewModel = ReportsVM()
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignWallet()
        setupUI()
        loadData()
    }
    
    // MARK: - Actions
    @IBAction func didTapOnUserSettings(_ sender: UIBarButtonItem) {
        openUserSettings(sender)
    }
    
    // MARK: - Private
    
    /// The wallet is in the viewModel of the first ViewController, retrieve it to be used here
    fileprivate func assignWallet() {
        // Get the previous fetched data from the Dashboard controller
        if let nv = tabBarController?.viewControllers?[0] as? UINavigationController, let dashboard = nv.viewControllers.first as? DashboardVC {
            viewModel.wallet = dashboard.viewModel.wallet
        }
    }
    
    // MARK: - Private functions
    fileprivate func setupUI() {
        
    }
    
    fileprivate func populateData() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GraphsPageVC") as! GraphsPageVC
        vc.history = viewModel.history
        self.addChildViewControllerWithView(vc, toView: container)
    }
    
    /// Using Dispatchgroup to join the two calls to the API
    fileprivate func loadData() {
        guard viewModel.wallet != nil else {
            return
        }
        
        let group = DispatchGroup()
        // Fetch the data
        showIndicator()
        group.enter()
        viewModel.getHistory { [weak self] error, response in
            if let error = error {
                print(error)
                self?.showError(error.localizedDescription)
            }
            else {
                self?.viewModel.history = response?.history
            }
            group.leave()
        }
        
        group.enter()
        viewModel.getPayouts { [weak self] error, response in
            if let error = error {
                print(error)
                self?.showError(error.localizedDescription)
            }
            else {
                self?.viewModel.payouts = response?.payouts
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