//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Marek on 13.10.2023.
//

import XCTest

final class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("b")
        
        let button = app.collectionViews.staticTexts["Beijing (China)"]
        
        if button.waitForExistence(timeout: 5) {
            button.tap()
            
            XCTAssert(app.staticTexts["Beijing"].waitForExistence(timeout: 5))
            XCTAssert(app.staticTexts["China"].waitForExistence(timeout: 5))
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
