//
//  UserDefaultExtensions.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import UIKit

/** Extension created to be used as a NameSpace for the
 ** User settings constants
 */
extension UserDefaults {
    enum keys {
        /** The app did run once */
        static let wallet = "USER_WALLET"
        static let lastFetch = "LAST_FETCH_DATA"
        static let previousCurrentStatus = "PREVIOUS_CURRENT_STATUS"
        static let fetchData = "FETCH_DATA"
    }
    
    enum images {
        static let arrowUp      = "arrow.up"
        static let arrowDown    = "arrow.down"
        static let equal        = "equal"
    }
}
