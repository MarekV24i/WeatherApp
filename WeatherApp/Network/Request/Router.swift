//
//  APIRouter.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import Foundation

enum Router {
    
    case searchCity(term: String)
    case currentconditions(locationKey: String)
    
    var apiKey: URLQueryItem {
        return URLQueryItem(name: "apikey", value: "fqd9KZE3yuxP6JBLF85wnl4lis8qoUCX")
    }
    
    var host: String {
        switch self {
        case .searchCity, .currentconditions:
            return "dataservice.accuweather.com"
        }
    }

    var scheme: String {
        switch self {
        case .searchCity,.currentconditions:
            return "https"
        }
    }
    
    var path: String {
        switch self {
        case .searchCity:
            return "/locations/v1/cities/autocomplete"
        case .currentconditions(let locationKey):
            return "/currentconditions/v1/\(locationKey)"
        }
    }

    var method: String {
        switch self {
        case .searchCity, .currentconditions:
            return "GET"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .searchCity(let term):
            return [self.apiKey, URLQueryItem(name: "q", value: term)]
        case .currentconditions:
            return [self.apiKey, URLQueryItem(name: "details", value: "true")]
        }
        
    }
}
