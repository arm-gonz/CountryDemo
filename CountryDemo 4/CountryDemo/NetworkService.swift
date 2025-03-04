//
//  NetworkService.swift
//  CountryDemo
//

import Foundation

class NetworkingService {
    
    var getUrl = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
    
    func getCountriesAPI(completion: @escaping (Result<[CountryBaseModel], Error>) -> Void) {
        guard let url = URL(string:getUrl ) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let Countries = try JSONDecoder().decode([CountryBaseModel].self, from: data)
                completion(.success(Countries))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
