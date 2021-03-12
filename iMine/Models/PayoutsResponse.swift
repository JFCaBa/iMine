//
//  PayoutsResponse.swift
//  iMine
//
//  Created by Jose Catala on 12/03/2021.
//

import Foundation

import Foundation

// MARK: - HistoryModel
struct PayoutsResponse: Codable {
    let payouts: [PayoutEntity]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case payouts = "data"
    }
}

extension PayoutsResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PayoutsResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - PayoutEntity
struct PayoutEntity: Codable {
    let paidOn, start, end, amount: Int
    let txHash: String
}

extension PayoutEntity {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PayoutEntity.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
