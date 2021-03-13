//
//  CurrentStatus.swift
//  iMine
//
//  Created by Jose Catala on 10/03/2021.
//
// To parse the JSON, add this file to your project and do:
//
//   let currentStatus = try CurrentStatus(json)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCurrentStatus { response in
//     if let currentStatus = response.result.value {
//       ...
//     }
//   }

import Foundation

// MARK: - CurrentStatus
struct StatusResponse: Codable {
    let status: String?
    let parameter: Status?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case parameter = "data"
    }
}

extension StatusResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StatusResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
}

// MARK: - Status
struct Status: Codable {
    let time, lastSeen, reportedHashrate, currentHashrate, validShares, averageHashrate, activeWorkers, unpaid, unconfirmed, coinsPerMin, usdPerMin, btcPerMin: Double?
    let staleShares, invalidShares: Int?
}

extension Status {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Status.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
}


// MARK: - Helper functions for creating encoders and decoders
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
