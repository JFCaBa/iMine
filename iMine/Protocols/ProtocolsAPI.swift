//
//  ProtocolsAPI.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//

import Foundation
import Alamofire

protocol ProtocolsAPI {
    /// Needs to be implemente in the class to use this protocol
    var wallet: String! { get set }
    /// Fetch the status from the API
    /// - Parameter completion: Returns an Error or a CurrentStatus object
    func getStatus(completion: @escaping (Error?, CurrentStatus?)-> ())
}

extension ProtocolsAPI {
    func getStatus(completion: @escaping (Error?, CurrentStatus?)-> ()) {
        guard let wallet = wallet else {
            completion(nil, nil)
            return
        }
        let url = "https://api.ethermine.org/miner/\(wallet)/currentStats"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    do {
                        if JSONSerialization.isValidJSONObject(json) {
                            let data = try JSONSerialization.data(withJSONObject: json, options: .sortedKeys)
                            print(String(bytes: data, encoding: .utf8)!)
                            let status =  try CurrentStatus(data: data)
                            completion(nil, status)
                        }
                    }
                    catch let error as NSError {
                        print(error.localizedDescription)
                        completion(error, nil)
                    }
                }
            case .failure(let error):
                print(error)
                completion(error, nil)
            }
        }
    }
    
    func isValidWalletAddress() -> Bool {
        guard let address = wallet else { return false }
        return address.count == 42
    }
}
