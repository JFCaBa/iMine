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
        willSet {
            // Store the actual values before to update for comparison
            previousCurrentStatus = currentStatus
        }
        didSet {
            // Update the cached date the values have been updated
            let date = Date()
            UserDefaults.standard.setValue(date, forKey: UserDefaults.keys.lastFetch)
        }
    }
    
    // Need to store the previous status to draw and color the up/down/equal indicators
    var previousCurrentStatus: CurrentStatus!
    
    /// The API updates the values every 6 minutes, makes no sense to call and get the same values than the last time
    var canFetchData: Bool {
        guard let date = UserDefaults.standard.object(forKey: UserDefaults.keys.lastFetch) as? Date else {
            return true
        }
        return Date() > date.addingTimeInterval(60) || nil == currentStatus
    }
    
    // Dashboard
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
        guard let previousCurrentStatus = previousCurrentStatus else {
            return nil
        }
        var imageName = UserDefaults.images.arrowUp
        if previousCurrentStatus.parameter?.currentHashrate ?? 0 > currentStatus.parameter?.currentHashrate ?? 0 {
            imageName = UserDefaults.images.arrowDown
        }
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        return image
    }
    
    var averageImage: UIImage? {
        guard let previousCurrentStatus = previousCurrentStatus else {
            return nil
        }
        var imageName = UserDefaults.images.arrowUp
        if previousCurrentStatus.parameter?.averageHashrate ?? 0 > currentStatus.parameter?.averageHashrate ?? 0 {
            imageName = UserDefaults.images.arrowDown
        }
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        return image
    }
    
    var reportedImage: UIImage? {
        guard let previousCurrentStatus = previousCurrentStatus else {
            return nil
        }
        var imageName = UserDefaults.images.arrowUp
        if previousCurrentStatus.parameter?.reportedHashrate ?? 0 > currentStatus.parameter?.reportedHashrate ?? 0 {
            imageName = UserDefaults.images.arrowDown
        }
        let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        return image
    }
    
    var currentImageTintColor: UIColor {
        guard let previousCurrentStatus = previousCurrentStatus else {
            return .clear
        }
        var color = UIColor.theBlue
        if previousCurrentStatus.parameter?.currentHashrate ?? 0 > currentStatus.parameter?.currentHashrate ?? 0 {
            color = UIColor.theRed
        }
        return color
    }
    
    var averageImageTintColor: UIColor {
        guard let previousCurrentStatus = previousCurrentStatus else {
            return .clear
        }
        var color = UIColor.theBlue
        if previousCurrentStatus.parameter?.averageHashrate ?? 0 > currentStatus.parameter?.averageHashrate ?? 0 {
            color = UIColor.theRed
        }
        return color
    }
    
    var reportedImageTintColor: UIColor {
        guard let previousCurrentStatus = previousCurrentStatus else {
            return .clear
        }
        var color = UIColor.theBlue
        if previousCurrentStatus.parameter?.reportedHashrate ?? 0 > currentStatus.parameter?.reportedHashrate ?? 0 {
            color = UIColor.theRed
        }
        return color
    }
    
    // Summary
    var earningsDay: String {
        guard let usd = currentStatus.parameter?.usdPerMin else { return "0.0" }
        let value = usd * 60 * 24
        return currencyFromValue(value)
    }
    
    var earningsWeek: String {
        guard let usd = currentStatus.parameter?.usdPerMin else { return "0.0" }
        let value = usd * 60 * 24 * 7
        return currencyFromValue(value)
    }
    
    var earningsMonth: String {
        guard let usd = currentStatus.parameter?.usdPerMin else { return "0.0" }
        let value = usd * 60 * 24 * 30
        return currencyFromValue(value)
    }
    
    var earningsYear: String {
        guard let usd = currentStatus.parameter?.usdPerMin else { return "0.0" }
        let value = usd * 60 * 24 * 365
        return currencyFromValue(value)
    }
    
    var unpaid: String {
        guard let units = currentStatus.parameter?.unpaid else { return "0.0" }
        let value =  units / 10e17
        return String(format: "%0.8f", value)
    }
    
    var workers: String {
        guard let workers = currentStatus.parameter?.activeWorkers else { return "0" }
        let value = Int(workers)
        return "\(value)"
    }
    
    var invalid: String {
        guard let value = currentStatus.parameter?.invalidShares else { return "0" }
        return "\(value)"
    }
    
    var stale: String {
        guard let value = currentStatus.parameter?.staleShares else { return "0" }
        return "\(value)"
    }
}

extension DashboardVM: ProtocolsAPI {
    func currencyFromValue(_ value: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale(identifier: "us_US")
        let priceString = currencyFormatter.string(from: NSNumber(value: value))!
        return priceString
    }
}
