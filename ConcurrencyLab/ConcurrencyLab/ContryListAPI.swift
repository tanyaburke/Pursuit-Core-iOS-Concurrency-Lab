//
//  ContryListAPI.swift
//  ConcurrencyLab
//
//  Created by Tanya Burke on 1/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

struct CountryListAPI{
    static func getListOfCountries(completion: @escaping (Result<[CountryList],AppError>)->()){
        let endPointURLString = "https://restcountries.eu/rest/v2/name/united"
        guard let url = URL(string: endPointURLString) else{
           completion (.failure(.badURL(endPointURLString)))
            return
        }
//        let countryList = [CountryList]()
        NetworkHelper.shared.performDataTask(with:url) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let countryList = try JSONDecoder().decode([CountryList].self, from: data)
                    completion(.success(countryList))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
