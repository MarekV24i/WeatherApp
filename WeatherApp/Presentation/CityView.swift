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
            Task.init {
                do {
                    screenState = .loading
                    try useCases.getConditions.execute(cityKey: cityKey)
                } catch {
                    screenState = .empty
                }
            }
        })
        .onChange(of: appState.conditions) { newValue in
            guard let newConditions = newValue.first else {
                screenState = .empty
                return
            }
            viewModel = ConditionsViewModelMapper.map(model: newConditions)
            screenState = .content
        }
    }
}
