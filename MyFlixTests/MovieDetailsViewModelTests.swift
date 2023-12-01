//
//  MovieDetailsViewModelTests.swift
//  MyFlixTests
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import XCTest
@testable import MyFlix

final class MovieDetailsViewModelTests: XCTestCase {
  func test_getMovieDetailsFailed() {
    let expectation = expectation(description: "Movie details fetch fails")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = HttpServiceMock(shouldThrowError: true)
    let viewmodel = MovieDetailsViewModel(httpService: httpService)

    Task {
      await viewmodel.getMovieDetails(forId: 2)
      try await Task.sleep(for: .milliseconds(100))
      expectation.fulfill()
      XCTAssertNil(viewmodel.detail)
      XCTAssert(viewmodel.hasError)
    }
  }

  func test_getMovieDetailsSuccess() {
    let expectation = expectation(description: "Movie details are fetched successfully")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = HttpServiceMock()
    let viewmodel = MovieDetailsViewModel(httpService: httpService)

    Task {
      await viewmodel.getMovieDetails(forId: 2)
      try await Task.sleep(for: .milliseconds(100))
      expectation.fulfill()
      XCTAssertNotNil(viewmodel.detail)
      XCTAssertFalse(viewmodel.hasError)
    }
  }

  func test_getSimilarMovies() {
    let movies = [Movie(id: 1, posterPath: ""), Movie(id: 2, posterPath: "")]
    let expectation = expectation(description: "Similar movies are fetched successfully")
    defer {
      waitForExpectations(timeout: 2)
    }

    let httpService = HttpServiceMock(movies: movies)
    let viewmodel = MovieDetailsViewModel(httpService: httpService)

    Task {
      await viewmodel.getSimilarMovies(forId: 2)
      try await Task.sleep(for: .milliseconds(100))
      expectation.fulfill()
      XCTAssertEqual(viewmodel.similarMovies.count, movies.count)
    }
  }
}
