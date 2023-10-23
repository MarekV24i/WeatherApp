//
//  NetworkUseCase.swift
//  WeatherApp
//
//  Created by Marek on 20.10.2023.
//

// UseCase which performs network loading
class NetworkUseCase {
    
    let repository: NetworkRepository
    let appState: AppState
    var loadTask: Task<(), Error>?
    
    init(repository: NetworkRepository, appState: AppState) {
        self.repository = repository
        self.appState = appState
    }
}
