//
//  MoviesViewModelTests.swift
//  MyFlixTests
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import XCTest
@testable import MyFlix

final class MoviesViewModelTests: XCTestCase {
  func test_getMoviesSuccess() {
    // swiftlint:disable:next line_length
    let expectation = expectation(description: "Popular, trending, top rated and upcoming movies are fetched successfully")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = MoviesVMHttpServiceMock()
    let viewmodel = MoviesViewModel(httpService: httpService)

    Task {
      await viewmodel.getMovies()
      try await Task.sleep(for: .milliseconds(500))
      expectation.fulfill()
      XCTAssertEqual(viewmodel.topRatedMovies.count, MoviesVMHttpServiceMock.topRatedMovies.count)
      XCTAssertEqual(viewmodel.popularMovies.count, MoviesVMHttpServiceMock.popularMovies.count)
      XCTAssertEqual(viewmodel.trendingMovies.count, MoviesVMHttpServiceMock.trendingMovies.count)
      XCTAssertEqual(viewmodel.upcomingMovies.count, MoviesVMHttpServiceMock.upcomingMovies.count)
      XCTAssertFalse(viewmodel.hasErrorLoadingMovies)
    }
  }

  func test_getMoviesFailure() {
    let expectation = expectation(description: "Popular, trending, top rated and upcoming movies all fail to fetch")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = MoviesVMHttpServiceMock(shouldThrowError: true)
    let viewmodel = MoviesViewModel(httpService: httpService)

    Task {
      await viewmodel.getMovies()
      try await Task.sleep(for: .milliseconds(100))
      expectation.fulfill()
      XCTAssertEqual(viewmodel.topRatedMovies.count, 0)
      XCTAssertEqual(viewmodel.popularMovies.count, 0)
      XCTAssertEqual(viewmodel.trendingMovies.count, 0)
      XCTAssertEqual(viewmodel.upcomingMovies.count, 0)
      XCTAssert(viewmodel.hasErrorLoadingMovies)
    }
  }
}
