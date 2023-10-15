//
//  getConditions.swift
//  WeatherApp
//
//  Created by Marek on 15.10.2023.
//

protocol GetConditionsUseCaseProtocol {
    func execute(cityKey: String) async throws
}

class GetConditionsUseCase: GetConditionsUseCaseProtocol {

    private let repository: NetworkRepository
    private let appState: AppState

    init(repository: NetworkRepository, appState: AppState) {
        self.repository = repository
        self.appState = appState
    }

    func execute(cityKey: String) async throws {
        do {
            let entities = try await repository.currentCondtions(cityKey: cityKey)
            
            appState.conditions = entities.map {
                ConditionsMapper.map(entity: $0)
            }
            print(appState.conditions)
        }
        catch {
            throw AppError.conditionsLoadFailed
        }
    }
}
