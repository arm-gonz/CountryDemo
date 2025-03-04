//
//  CountryBaseModel.swift
//  CountryDemo
//

import Foundation

struct CountryBaseModel : Codable {
    let capital : String?
    let code : String?
    let currency : Currency?
    let flag : String?
    let language : Language?
    let name : String?
    let region : String?

    enum CodingKeys: String, CodingKey {

        case capital = "capital"
        case code = "code"
        case currency = "currency"
        case flag = "flag"
        case language = "language"
        case name = "name"
        case region = "region"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        capital = try values.decodeIfPresent(String.self, forKey: .capital)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        currency = try values.decodeIfPresent(Currency.self, forKey: .currency)
        flag = try values.decodeIfPresent(String.self, forKey: .flag)
        language = try values.decodeIfPresent(Language.self, forKey: .language)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        region = try values.decodeIfPresent(String.self, forKey: .region)
    }

}
