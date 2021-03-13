//
//  LandingTabBarController.swift
//  iMine
//
//  Created by Jose Catala on 13/03/2021.
//

import UIKit

class LandingTabBarController: UITabBarController {

    // MARK: - Constants
    let fireTime: Double = 60.0
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: fireTime, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
        // Trigger a notification so the open classes will fetch new data
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserDefaults.keys.fetchData), object: nil)
    }
}
