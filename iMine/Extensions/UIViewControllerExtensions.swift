//
//  UIViewControllerExtensions.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    /// Convenient fuction to open the User settings
    /// - Parameter sender: The same UIBarButtonItem tapped on the class
    func openUserSettings(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "UserSettings") as? UserSettingsVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /// Convenient function to show an AlertController
    /// - Parameter error: A string with the error description
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
    
    // MARK: - UI stuff
    func addChildViewControllerWithView(_ childViewController: UIViewController, toView view: UIView? = nil) {
        let view: UIView = view ?? self.view
        childViewController.removeFromParent()
        childViewController.view.removeFromSuperview()
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childViewController.view)
        view.addConstraints([
            NSLayoutConstraint(item: childViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: childViewController.view!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        view.layoutIfNeeded()
    }
    
    func removeChildViewController(_ childViewController: UIViewController) {
        childViewController.removeFromParent()
        childViewController.willMove(toParent: nil)
        childViewController.removeFromParent()
        childViewController.didMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        view.layoutIfNeeded()
    }
}
