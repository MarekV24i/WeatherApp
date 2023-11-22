//
//  NetworkUseCase.swift
//  WeatherApp
//
//  Created by Marek on 20.10.2023.
//


// UseCase which performs network loading
public class NetworkUseCase {

    let repository: NetworkRepositoryProtocol
    let appState: AppState
    var loadTask: Task<(), Error>?

    public init(repository: NetworkRepositoryProtocol, appState: AppState) {
        self.repository = repository
        self.appState = appState
    }
}

public protocol NetworkRepositoryProtocol {

    // Returns list of cites based on search term provided
    func searchCity(term: String?) async throws -> [CityModel]

    // Loads weather conditions for specific city
    func currentCondtions(cityKey: String) async throws -> [ConditionsModel]
}
