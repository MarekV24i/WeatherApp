//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI
import DataLayer
import DomainLayer
import PresentationLayer

@main
struct WeatherApp: App {

    // Single source of truth
    @StateObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            // Inject AppState and UsesCases as environment objects so all views can access them easily
            // Place to insert mockup application state, use-cases or repository if needed (e.g. used in SearchView preview)
            SearchView().environmentObject(appState)
                .environmentObject(UseCaseContainer(repository: NetworkRepository(), appState: appState))
        }
    }
}
