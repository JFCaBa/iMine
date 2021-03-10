//
//  DashboardVM.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

struct DashboardVM {
    
    var wallet: String!
    
    var currentStatus: CurrentStatus! {
        didSet {
            let date = Date()
            UserDefaults.standard.setValue(date, forKey: UserDefaults.keys.lastFetch)
        }
    }
    
    /// The API updates the values every 6 minutes, makes no sense to call and get the same values than the last time
    var canFetchData: Bool {
        guard let date = UserDefaults.standard.object(forKey: UserDefaults.keys.lastFetch) as? Date else {
            return true
        }
        return Date() > date.addingTimeInterval(60) || nil == currentStatus
    }
    
    var current: String? {
        guard let currentHashrate = currentStatus.parameter?.currentHashrate else { return "0.0" }
        return String(format: "%0.2f", currentHashrate / 1000000)
    }
    
    var average: String? {
        guard let averageHashrate = currentStatus.parameter?.averageHashrate else { return "0.0" }
        return String(format: "%0.2f", averageHashrate / 1000000)
    }
    
    var reported: String? {
        guard let reportedHashrate = currentStatus.parameter?.reportedHashrate else { return "0.0" }
        return String(format: "%0.2f", reportedHashrate / 1000000)
    }
    
    var currentImage: UIImage? {
        let image = UIImage(systemName: UserDefaults.images.arrowUp)?.withRenderingMode(.alwaysTemplate)
        return image
    }
    
    var averageImage: UIImage? {
        let image = UIImage(systemName: UserDefaults.images.arrowUp)?.withRenderingMode(.alwaysTemplate)
        return image
    }
    
    var reportedImage: UIImage? {
        let image = UIImage(systemName: UserDefaults.images.arrowUp)?.withRenderingMode(.alwaysTemplate)
        return image
    }
    
    var currentImageTintColor: UIColor {
        return UIColor.theBlue
    }
    
    var averageImageTintColor: UIColor {
        return UIColor.theBlue
    }
    
    var reportedImageTintColor: UIColor {
        return UIColor.theBlue
    }
}

extension DashboardVM: ProtocolsAPI {
    
}
