//
//  MyFlixUITestsLaunchTests.swift
//  MyFlixUITests
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import XCTest
@testable import MyFlix

final class MyFlixUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-ui-testing", "-ui-networking-success"]
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
