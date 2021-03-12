//
//  ReportsVM.swift
//  iMine
//
//  Created by Jose Catala on 12/03/2021.
//

import Foundation

struct ReportsVM {
    var wallet: String!
    var maxOfCols: Int = 50
    
    var history: [HistoryEntity]!
    var payouts: [PayoutEntity]!
    
    var actual: [Double] {
        let value = history.map({$0.currentHashrate / 1000000})
        let sliced = value.suffix(maxOfCols)
        return Array(sliced)
    }
    
    // Hashrate
    var average: [Double] {
        let value = history.map({$0.averageHashrate / 1000000})
        let sliced = value.suffix(maxOfCols)
        return Array(sliced)
    }
    
    var reported: [Double] {
        let value = history.map({$0.reportedHashrate / 1000000})
        let sliced = value.suffix(maxOfCols)
        return Array(sliced)
    }
    
    // Payout
    var payout: [Double] {
        let value = payouts.map({Double($0.amount)})
        return value
    }
    
    var sliderValue: Float {
        return Float(maxOfCols)
    }
}


extension ReportsVM: ProtocolsAPI {
    
}
