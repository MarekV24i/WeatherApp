//
//  ContentView.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

struct SearchView: View {
    
    @State var textfiledString = ""
    @State private var screenState: ScreenState = .initial
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var useCases: UseCaseContainer
        
    var body: some View {
        NavigationView {
            VStack {
                Text("Search city")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                TextField("Type to search for city", text: $textfiledString)
                .onChange(of: textfiledString) { newValue in
                    guard !textfiledString.isEmpty else {
                        screenState = .initial
                        return
                    }
                    screenState = .loading
                    Task {
                        do {
                            try useCases.searchCity.execute(term: newValue)
                        } catch {
                            screenState = .empty
                        }
                    }
                }
                .padding(10)
                .background(.gray.opacity(0.3))
                .cornerRadius(10)
            
                switch screenState {
                case .initial:
                    Spacer()
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .content:
                    List(appState.cities, id: \.id) { city in
                        NavigationLink {
                            CityView().onAppear{
                                useCases.selectCity.execute(city)
                            }
                        } label: {
                            Text(city.name ?? "unknown_city")
                        }
                    }
                    .listStyle(.plain)
                case .empty:
                    Spacer()
                    Text("Nothing was found")
                    Spacer()
                }
            }
            .padding()
        }
        .onAppear() {
            if !appState.cities.isEmpty {
                screenState = .content
            }
        }
        .onChange(of: appState.cities) { newValue in
            screenState = appState.cities.isEmpty ? .empty : .content
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
