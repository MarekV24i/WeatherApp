//
//  CityView.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

struct CityView: View {
    
    @State private var screenState: ScreenState = .initial
    @State private var viewModel = ConditionsViewModel()
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var useCases: UseCaseContainer
    
    var body: some View {
        VStack {
            switch screenState {
            case .initial:
                EmptyView()
            case .loading:
                Spacer()
                ProgressView()
                Spacer()
            case .empty:
                Spacer()
                Text("empty_conditions")
                Spacer()
            case .content:
                Spacer()
                Text(appState.selectedCity?.name ?? "")
                    .font(.system(size: 40, weight: .bold))
                Text(appState.selectedCity?.country ?? "")
                Spacer()
                Group {
                    Text(viewModel.text)
                        .font(.system(size: 30, weight: .bold))
                        .padding(30)
                    Text(viewModel.temperature)
                        .font(.system(size: 30, weight: .bold))
                        .padding(5)
                    Text(viewModel.feelsLike)
                        .padding(5)
                }
                Spacer()
                Group {
                    Text(viewModel.visibility)
                        .padding(5)
                    Text(viewModel.precipitation)
                        .padding(5)
                    Text(viewModel.time)
                        .padding(20)
                }
                Spacer()
                if let link = viewModel.link {
                    Link("open_link", destination: link)
                }
            }
        }
        .onChange(of: appState.selectedCity, perform: { _ in
            loadConditions()
        })
        .onChange(of: appState.conditions) { _ in
            updateViewModel()
        }
        .onAppear {
            guard let _ = appState.selectedCity, let _ = appState.conditions else {
                screenState = .initial
                return
            }
            updateViewModel()
        }
    }
    
    private func loadConditions() {
        guard let cityKey = appState.selectedCity?.key else {
            screenState = .initial
            return
        }
        Task {
            do {
                screenState = .loading
                try await useCases.getConditions.execute(cityKey: cityKey)
            } catch {
                screenState = .empty
            }
        }
    }
    
    private func updateViewModel() {
        guard let conditions = appState.conditions?.first else {
            screenState = .empty
            return
        }
        viewModel = ConditionsViewModelMapper.map(model: conditions)
        screenState = .content
    }
}


struct SearchView_Previews: PreviewProvider {
        
    // Use mockup data for preview
    static let appState = AppState(selectedCity: MockupData.mockCities.first,
                                   conditions: [MockupData.mockConditions])
    
    static var previews: some View {
        CityView().environmentObject(appState).environmentObject(UseCaseContainer(repository: NetworkRepository(), appState: appState))
    }
}
