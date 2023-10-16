//
//  CityView.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

struct CityView: View {
    
    @State private var screenState: ScreenState = .initial
    
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
                    Text(appState.conditions.first?.text ?? "")
                        .font(.system(size: 30, weight: .bold))
                        .padding(30)
                    if let value = appState.conditions.first?.temperature?.value, let unit = appState.conditions.first?.temperature?.unit {
                        Text(String(format: "%.1f °%@", value, unit))
                            .font(.system(size: 30, weight: .bold))
                            .padding(5)
                    }
                    if let value = appState.conditions.first?.feelsLike?.value, let unit = appState.conditions.first?.feelsLike?.unit {
                        Text(String(format: "Feeels like %.1f °%@", value, unit))
                            .padding(5)
                    }
                }
                Spacer()
                Group {
                    if let value = appState.conditions.first?.visibility?.value, let unit = appState.conditions.first?.visibility?.unit {
                        Text(String(format: "Visibility %.1f %@", value, unit))
                            .padding(5)
                    }
                    if let value = appState.conditions.first?.precipitation?.value, let unit = appState.conditions.first?.precipitation?.unit {
                        Text(String(format: "Precipitation %.1f %@", value, unit))
                            .padding(5)
                    }
                    if let time = appState.conditions.first?.time {
                        let formatter = DateFormatter()
                        //formatter.dateFormat = "HH:mm dd.MM.yyyy"
                    //    Text(formatter.date(from: time) ?? "")
                    //        .padding(5)
                    }
                }
                Spacer()
                if let link = appState.conditions.first?.link, let URL = URL(string: link) {
                    Link("Open in safari", destination: URL)
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
                    try await useCases.getConditions.execute(cityKey: cityKey)
                    screenState = .content
                } catch {
                    screenState = .empty
                }
            }
        })
    }
}
