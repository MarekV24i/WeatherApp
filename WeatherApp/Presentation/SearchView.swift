//
//  ContentView.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

struct SearchView: View {
    
    @State var textfiledString = ""

    @State private var screenState: ScreenState = .loading
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var useCases: UseCaseContainer
        
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    TextField("search_hint",
                              text: $textfiledString)
                    .onChange(of: textfiledString) { newValue in
                        guard !textfiledString.isEmpty else {
                            return
                        }
                        Task.init {
                            do {
                                try await useCases.searchCity.execute(term: textfiledString)
                            } catch {
                                print("Fetching establishments failed with error \(error)")
                            }
                        }
                    }
                    .padding(10)
                }
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.top, 30)
                
                Text("origin_airport")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                ZStack {
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
                    
                    if screenState == .loading {
                        ProgressView()
                    } else if screenState == .empty {
                        Text("empty_airports")
                    }
                }
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 20)
            }
            .environmentObject(appState)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
