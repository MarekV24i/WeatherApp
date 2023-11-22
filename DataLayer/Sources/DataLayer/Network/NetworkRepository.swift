//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import DomainLayer

public class NetworkRepository: NetworkRepositoryProtocol {

    public init() {}

    public func searchCity(term: String?) async throws -> [CityModel] {
        let response: [CityEntity] = try await RequestDispatcher.request(apiRouter: .searchCity(term: term ?? ""))
        return response.map { CityMapper.map(entity: $0) }
    }

    public func currentCondtions(cityKey: String) async throws -> [ConditionsModel] {
        let response: [ConditionsEntity] = try await RequestDispatcher.request(apiRouter: .currentconditions(locationKey: cityKey))
        return response.map { ConditionsMapper.map(entity: $0) }
    }

}
