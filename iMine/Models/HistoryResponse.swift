//
//  HistoryResponse.swift
//  iMine
//
//  Created by Jose Catala on 12/03/2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let historyModel = try HistoryModel(json)

import Foundation

// MARK: - HistoryModel
struct HistoryResponse: Codable {
    let history: [HistoryEntity]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case history = "data"
    }
}

extension HistoryResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HistoryResponse.self, from: data)
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

// MARK: - HistoryEntity
struct HistoryEntity: Codable {
    let activeWorkers: Int?
    let averageHashrate, currentHashrate, reportedHashrate: Double
    let invalidShares, staleShares, time: Int?
    let validShares: Int?
}

extension HistoryEntity {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HistoryEntity.self, from: data)
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
