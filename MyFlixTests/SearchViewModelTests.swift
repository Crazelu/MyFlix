//
//  SearchViewModelTests.swift
//  MyFlixTests
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import XCTest
@testable import MyFlix

final class SearchViewModelTests: XCTestCase {
  func testInitialSearch() {
    let movies = [Movie(id: 20, posterPath: "")]

    let expectation = expectation(description: "Initial search request is run")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = HttpServiceMock(movies: movies)
    let viewmodel = SearchViewModel(httpService: httpService)

    Task {
      try await Task.sleep(for: .seconds(1))
      expectation.fulfill()
      XCTAssertEqual(viewmodel.movies.count, movies.count)
    }
  }

  func testFailedSearch() {
    let expectation = expectation(description: "Search request fails")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = HttpServiceMock(shouldThrowError: true)
    let viewmodel = SearchViewModel(httpService: httpService)

    Task {
      try await Task.sleep(for: .seconds(1))
      expectation.fulfill()
      XCTAssert(viewmodel.hasError)
      XCTAssertFalse(viewmodel.loading)
    }
  }

  func testEmptySearchResult() {
    let expectation = expectation(description: "Search request returns empty movie list")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = HttpServiceMock()
    let viewmodel = SearchViewModel(httpService: httpService)

    Task {
      try await Task.sleep(for: .seconds(1))
      expectation.fulfill()
      XCTAssert(viewmodel.hasEmptyResult)
      XCTAssertFalse(viewmodel.loading)
      XCTAssertFalse(viewmodel.hasError)
    }
  }
}
