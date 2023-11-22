//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Marek on 13.10.2023.
//

import XCTest
@testable import WeatherApp
@testable import DataLayer
@testable import PresentationLayer

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
                  && cityModel.name == name,
                  "Network > Domain city mapping failed")

        let cityViewModel = CityViewModelMapper.map(model: cityModel)

        XCTAssert(cityViewModel.key == key
                  && cityViewModel.country == country
                  && cityViewModel.name == name,
                  "Domain > Presentation city mapping failed")

    }

    func testConditionsMapping() throws {

        let time = Date()
        let text = "sunny"
        let value: Double = 1.2
        let unit = "C"
        let link = "www.google.com"

        var conditionsEntity = ConditionsEntity()
        conditionsEntity.LocalObservationDateTime = ISO8601DateFormatter().string(from: time)
        conditionsEntity.WeatherText = text
        conditionsEntity.Temperature = ConditionsEntity.Units(Metric: ConditionsEntity.UnitsData(Value: value, Unit: unit))
        conditionsEntity.ApparentTemperature = ConditionsEntity.Units(Metric: ConditionsEntity.UnitsData(Value: value, Unit: unit))
        conditionsEntity.Visibility = ConditionsEntity.Units(Metric: ConditionsEntity.UnitsData(Value: value, Unit: unit))
        conditionsEntity.PrecipitationSummary = ConditionsEntity.Precipitation(Precipitation:
        ConditionsEntity.Units(Metric: ConditionsEntity.UnitsData(Value: value, Unit: unit)))
        conditionsEntity.MobileLink = link

        let conditionsModel = ConditionsMapper.map(entity: conditionsEntity)

        XCTAssert(conditionsModel.time?.ISO8601Format() == time.ISO8601Format()
                  && conditionsModel.text == text
                  && conditionsModel.temperature?.value == value
                  && conditionsModel.temperature?.unit == unit
                  && conditionsModel.feelsLike?.value == value
                  && conditionsModel.feelsLike?.unit == unit
                  && conditionsModel.precipitation?.value == value
                  && conditionsModel.precipitation?.unit == unit
                  && conditionsModel.visibility?.value == value
                  && conditionsModel.visibility?.unit == unit
                  && conditionsModel.link == link,
                  "Network > Domain conditions mapping failed")

        let conditionsViewModel = ConditionsViewModelMapper.map(model: conditionsModel)

        XCTAssert(conditionsViewModel.text == text
                  && conditionsViewModel.time.contains(String(Calendar.current.component(.hour, from: time)))
                  && conditionsViewModel.time.contains(String(Calendar.current.component(.minute, from: time)))
                  && conditionsViewModel.time.contains(String(Calendar.current.component(.hour, from: time)))
                  && conditionsViewModel.time.contains(String(Calendar.current.component(.day, from: time)))
                  && conditionsViewModel.time.contains(String(Calendar.current.component(.month, from: time)))
                  && conditionsViewModel.time.contains(String(Calendar.current.component(.year, from: time)))
                  && conditionsViewModel.temperature.contains(String(value))
                  && conditionsViewModel.temperature.contains(String(unit))
                  && conditionsViewModel.feelsLike.contains(String(value))
                  && conditionsViewModel.feelsLike.contains(String(unit))
                  && conditionsViewModel.precipitation.contains(String(value))
                  && conditionsViewModel.precipitation.contains(String(unit))
                  && conditionsViewModel.visibility.contains(String(value))
                  && conditionsViewModel.visibility.contains(String(unit))
                  && conditionsViewModel.link?.absoluteString == link,
                  "Domain > Presentation conditions mapping failed")

    }

    func testConditionsLoad() async throws {

        let cityKey = "123291"

        do {
            let conditions = try await NetworkRepository().currentCondtions(cityKey: cityKey)
            XCTAssert(!conditions.isEmpty, "Empty conditions loaded")
        } catch {
            XCTFail("Failed to load conditions")
        }
    }

    func testCitiesLoad() async throws {

        let searchTerm = "B"

        do {
            let conditions = try await NetworkRepository().searchCity(term: searchTerm)
            XCTAssert(!conditions.isEmpty, "No cities found")
        } catch {
            XCTFail("Failed to search for cities")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
