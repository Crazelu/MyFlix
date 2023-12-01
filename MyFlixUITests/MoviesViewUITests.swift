//
//  MyFlixUITests.swift
//  MyFlixUITests
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import XCTest
@testable import MyFlix

final class MoviesViewUITests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  private var app: XCUIApplication!

  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
  }

  override func tearDown() {
    app = nil
  }

  func test_moviesViewHasCorrectNumberOfSectionsWhenScreenLoadsSuccessfully() {
    app.launchArguments = ["-ui-testing", "-networking-success"]
    app.launch()

    XCTAssertTrue(app.scrollViews["moviesScrollView"].waitForExistence(timeout: 2))
    XCTAssertFalse(app.buttons["Retry"].waitForExistence(timeout: 1))
  }

  func test_moviesViewHasErrorViewWhenScreenDoesNotLoadSuccessfully() {
    app.launchArguments = ["-ui-testing"]
    app.launch()

    XCTAssertTrue(app.buttons["Retry"].waitForExistence(timeout: 1))
    XCTAssertFalse(app.scrollViews["moviesScrollView"].waitForExistence(timeout: 1))
  }
}
