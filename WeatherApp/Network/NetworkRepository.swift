//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

protocol NetworkRepositoryProtocol {
    
    // Returns list of cites based on search term provided
    func searchCity(term: String?) async throws -> [CityEntity]
    
    // Loads weather conditions for specific city
    func currentCondtions(cityKey: String) async throws -> [ConditionsEntity]
}


class NetworkRepository: NetworkRepositoryProtocol {
    
    func searchCity(term: String?) async throws -> [CityEntity] {
        let cities: [CityEntity] = try await RequestDispatcher.request(apiRouter: .searchCity(term: term ?? ""))
        return cities
    }
    
    func currentCondtions(cityKey: String) async throws -> [ConditionsEntity] {
        let conditions: [ConditionsEntity] = try await RequestDispatcher.request(apiRouter: .currentconditions(locationKey: cityKey))
        return conditions
    }
    
}
