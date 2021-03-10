//
//  UIViewControllerExtensions.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func openUserSettings(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "UserSettings") as? UserSettings else { return }
        present(vc, animated: true, completion: nil)
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - MBProgressHUD
    func showIndicator(withTitle title: String = "", and description: String = "") {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
            self.view.isUserInteractionEnabled = false
            let Indicator = MBProgressHUD.showAdded(to: self.view, animated: false)
            Indicator.label.text = NSLocalizedString(title, comment: "")
            Indicator.isUserInteractionEnabled = false
            Indicator.detailsLabel.text = description
            Indicator.show(animated: true)
        }
    }
    func hideIndicator() {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
