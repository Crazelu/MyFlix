//
//  SearchViewUITests.swift
//  MyFlixUITests
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import XCTest

final class SearchViewUITests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  private var app: XCUIApplication!

  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
  }

  override func tearDown() {
    app = nil
  }

  func test_searchViewHasScrollViewWhenSearchRequestCompletesSuccessfully() {
    app.launchArguments = ["-ui-testing", "-networking-success"]
    app.launch()

    app.tabBars.buttons["Search"].tap()

    XCTAssertTrue(app.textFields["Search"].waitForExistence(timeout: 2))
    XCTAssertTrue(app.scrollViews["searchScrollView"].waitForExistence(timeout: 2))
  }

  func test_searchViewHasErrorViewWhenSearchRequestFails() {
    app.launchArguments = ["-ui-testing"]
    app.launch()

    app.tabBars.buttons["Search"].tap()

    XCTAssertTrue(app.textFields["Search"].waitForExistence(timeout: 2))
    XCTAssertTrue(app.staticTexts["Something went wrong"].waitForExistence(timeout: 1))
    XCTAssertFalse(app.scrollViews["searchScrollView"].waitForExistence(timeout: 1))
  }
}
