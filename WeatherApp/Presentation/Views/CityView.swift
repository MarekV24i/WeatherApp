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
                Text("Weather coditions couldn't be loaded.")
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
                }
                Spacer()
                if let link = viewModel.link {
                    Link("Open in safari", destination: link)
                }
            }
        }
        .onChange(of: appState.selectedCity, perform: { _ in
            guard let cityKey = appState.selectedCity?.key else {
                screenState = .initial
                return
            }
            Task {
                do {
                    screenState = .loading
                    try useCases.getConditions.execute(cityKey: cityKey)
                } catch {
                    screenState = .empty
                }
            }
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
    
    static let mockCity = CityModel(
                            key: "123",
                            name: "Otrokovice",
                            country: "Czechia"
                        )
    
    static let mockConditions = ConditionsModel(
        time: Date(),
        text: "Hot (yet snowing)",
        temperature: ConditionsModel.UnitsData(value: 40.2, unit: "C"),
        feelsLike: ConditionsModel.UnitsData(value: 120, unit: "C"),
        visibility: ConditionsModel.UnitsData(value: 8432, unit: "km"),
        precipitation: ConditionsModel.UnitsData(value: 2000, unit: "mm"),
        link: "https://wwww.google.com"
    )
    
    static let appState = AppState(selectedCity: mockCity,
                                    conditions: [mockConditions])
    
    static var previews: some View {
        CityView().environmentObject(appState).environmentObject(UseCaseContainer(repository: NetworkRepository(), appState: appState))
    }
}
