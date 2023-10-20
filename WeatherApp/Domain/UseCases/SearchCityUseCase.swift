//
//  SearchCityUseCase.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

protocol SearchCityUseCaseProtocol {

    func execute(term: String) throws
}

class SearchCityUseCase: NetworkUseCase, SearchCityUseCaseProtocol {
    
    func execute(term: String) throws {
        loadTask?.cancel()
        
        loadTask = Task {
            do {
                let entities = try await repository.searchCity(term: term)
                DispatchQueue.main.async {
                    self.appState.cities = entities.map {
                        CityMapper.map(entity: $0)
                    }
                }
            }
            catch {
                throw AppError.citySearchFailed
            }
        }
    }
}
