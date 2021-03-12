//
//  Summary.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

class SummaryVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblWeek: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblUnpaid: UILabel!
    @IBOutlet weak var lblWorkers: UILabel!
    @IBOutlet weak var lblStale: UILabel!
    @IBOutlet weak var lblInvalid: UILabel!
    @IBOutlet weak var lblUnpaidTitle: UILabel!
    // MARK: - Ivars
    // MARK: - ViewModels
    var viewModel = DashboardVM()
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get the previous fetched data from the Dashboard controller
        if let nv = tabBarController?.viewControllers?[0] as? UINavigationController, let dashboard = nv.viewControllers.first as? DashboardVC {
            viewModel = dashboard.viewModel
            populateData()
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
        lblDay.text = viewModel.earningsDay
        lblWeek.text = viewModel.earningsWeek
        lblMonth.text = viewModel.earningsMonth
        lblYear.text = viewModel.earningsYear
        lblWorkers.text = viewModel.workers
        lblUnpaid.text = viewModel.unpaid
        lblInvalid.text = viewModel.invalid
        lblStale.text = viewModel.stale
    }
}
