//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Marek on 13.10.2023.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCityMapping() throws {
        
        let key = "1234"
        let name = "New York"
        let country = "USA"
        
        let cityEntity = CityEntity(
            Key: key,
            LocalizedName: name,
            Country: CityEntity.Country(LocalizedName: country)
        )
        
        let cityModel = CityMapper.map(entity: cityEntity)
        
        XCTAssert(cityModel.key == key
                  && cityModel.country == country
                  && cityModel.name == name, "Network > Domain city mapping failed")
        
        let cityViewModel = CityViewModelMapper.map(model: cityModel)
        
        XCTAssert(cityViewModel.key == key
                  && cityViewModel.country == country
                  && cityViewModel.name == name, "Domain > Presentation city mapping failed")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
