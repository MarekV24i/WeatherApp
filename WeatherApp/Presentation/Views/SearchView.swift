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
    @State private var viewModel = [CityViewModel]()
    
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
                    List(viewModel, id: \.id) { city in
                        NavigationLink {
                            CityView().onAppear{
                                useCases.selectCity.execute(CityViewModelMapper.map(viewModel: city))
                            }
                        } label: {
                            Text(city.label)
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
                updateViewModel()
                screenState = .content
            }
        }
        .onChange(of: appState.cities) { _ in
            updateViewModel()
            screenState = viewModel.isEmpty ? .empty : .content
        }
    }
    
    private func updateViewModel() {
        viewModel = appState.cities.map {
            CityViewModelMapper.map(model: $0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let mockCities = [CityModel(
                            key: "123",
                            name: "Otrokovice",
                            country: "Czechia"
                        ),
                        CityModel(
                            key: "456",
                            name: "New York",
                            country: "USA"
                        )
    ]
    
    static let appState = AppState(cities: mockCities)
    
    static var previews: some View {
        SearchView().environmentObject(appState).environmentObject(UseCaseContainer(repository: NetworkRepository(), appState: appState))
    }
}
