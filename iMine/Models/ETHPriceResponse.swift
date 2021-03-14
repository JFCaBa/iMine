//
//  ETHPriceResponse.swift
//  iMine
//
//  Created by Jose Catala on 14/03/2021.
//

import Foundation


// MARK: - ETHPriceResponse
struct ETHPriceResponse: Codable {
    let data: ETHValue?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: ETHPriceResponse convenience initializers and mutators
extension ETHPriceResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ETHPriceResponse.self, from: data)
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

// MARK: - DataClass
struct ETHValue: Codable {
    let base, currency, amount: String
}

// MARK: DataClass convenience initializers and mutators
extension ETHValue {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ETHValue.self, from: data)
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
