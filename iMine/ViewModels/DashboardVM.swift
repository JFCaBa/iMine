//
//  DashboardVM.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import Foundation

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
        return date > Date().addTimeInterval(360)
    }
}

extension DashboardVM: ProtocolsAPI {
    
}
