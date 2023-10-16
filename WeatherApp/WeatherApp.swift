//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    @StateObject var appState = AppState()

    var body: some Scene {
        WindowGroup {
            SearchView().environmentObject(appState).environmentObject(UseCaseContainer(repository: NetworkRepository(), appState: appState))
        }
    }
}

