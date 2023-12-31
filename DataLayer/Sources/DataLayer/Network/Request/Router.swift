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
        // API keys should be stored safely, normally I use git-secret (but in this demo lets keep it here)
        // NOTE: API is limited to 50 free requests daily, so here are some spare API keys if needed:
        // xqEe20JnTVNukGoMFYeM6CGNJHYuXky2
        // ob4AjFsm8BslUKmLGQF4GPppnPs4otSG
        // 0DyjFgu04fdv3eKLkxHEuvA01Or4tkub
        // fqd9KZE3yuxP6JBLF85wnl4lis8qoUCX
        // WFWyMD4unc6dDHh6qAdEUGJ5zD8I8c5a
        return URLQueryItem(name: "apikey", value: "xqEe20JnTVNukGoMFYeM6CGNJHYuXky2")
    }

    var host: String {
        switch self {
        case .searchCity, .currentconditions:
            return "dataservice.accuweather.com"
        }
    }

    var scheme: String {
        switch self {
        case .searchCity, .currentconditions:
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
