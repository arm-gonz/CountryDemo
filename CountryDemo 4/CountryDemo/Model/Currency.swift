//
//  Currency.swift
//  CountryDemo
//

import Foundation
struct Currency : Codable {
    let code : String?
    let name : String?
    let symbol : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
        case symbol = "symbol"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
    }
}
