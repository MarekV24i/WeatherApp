//
//  CityView.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

struct CityView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var useCases: UseCaseContainer
    
    var body: some View {
        VStack {
            Spacer()
            Text(appState.selectedCity?.name ?? "")
                .font(.system(size: 40, weight: .bold))
            Text("Czechia")
            Spacer()
            Group {
                Text(appState.conditions.first?.text ?? "")
                    .font(.system(size: 30, weight: .bold))
                    .padding(30)
                Text("\(appState.conditions.first?.temperature?.value ?? 0) \(appState.conditions.first?.temperature?.unit ?? "")")
                    .font(.system(size: 30, weight: .bold))
                    .padding(5)
                Text("Feeels like \(appState.conditions.first?.feelsLike?.value ?? 0) \(appState.conditions.first?.feelsLike?.unit ?? "")")
            }
            Spacer()
            Group {
                Text("Visibility \(appState.conditions.first?.visibility?.value ?? 0) \(appState.conditions.first?.visibility?.unit ?? "")")
                    .padding(5)
                Text("Precipitation \(appState.conditions.first?.precipitation?.value ?? 0) \(appState.conditions.first?.precipitation?.unit ?? "")")
                    .padding(5)
                Text(appState.conditions.first?.time ?? "")
                    .padding(5)
                
            }
            Spacer()
            if let link = appState.conditions.first?.link, let URL = URL(string: link) {
                Link("Open in safari", destination: URL)
            }
        }
        .onChange(of: appState.selectedCity, perform: { _ in
            guard let cityKey = appState.selectedCity?.key else {
                return
            }
            Task.init {
                do {
                    try await useCases.getConditions.execute(cityKey: cityKey)
                } catch {
                    print("Fetching establishments failed with error \(error)")
                }
            }
        })
    }
}
