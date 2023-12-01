//
//  UITestingHttpService.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import Foundation

class UITestingHttpServiceMock: HttpServiceInterface {
  let shouldThrowError: Bool

  init(shouldThrowError: Bool = false) {
    self.shouldThrowError = shouldThrowError
  }

  static let upcomingMovies = [
    Movie(id: 1, posterPath: ""),
    Movie(id: 2, posterPath: ""),
    Movie(id: 3, posterPath: "")
  ]
  static let trendingMovies = [
    Movie(id: 1, posterPath: "")
  ]
  static let popularMovies = [
    Movie(id: 1, posterPath: ""),
    Movie(id: 2, posterPath: "")
  ]
  static let topRatedMovies = [
    Movie(id: 1, posterPath: ""),
    Movie(id: 2, posterPath: ""),
    Movie(id: 3, posterPath: ""),
    Movie(id: 4, posterPath: "")
  ]
  static let otherMovies = [
    Movie(id: 1, posterPath: ""),
    Movie(id: 2, posterPath: ""),
    Movie(id: 3, posterPath: ""),
    Movie(id: 4, posterPath: ""),
    Movie(id: 5, posterPath: ""),
    Movie(id: 6, posterPath: ""),
    Movie(id: 7, posterPath: "")
  ]

  func getMovies(for url: URL?) async throws -> [Movie] {
    if shouldThrowError {
      throw HttpRequestError.requestFailed
    }

    switch url {
    case AppConstants.Urls.trendingMoviesUrl:
      return UITestingHttpServiceMock.trendingMovies
    case AppConstants.Urls.upcomingMoviesUrl:
      return UITestingHttpServiceMock.upcomingMovies
    case AppConstants.Urls.popularMoviesUrl:
      return UITestingHttpServiceMock.popularMovies
    case AppConstants.Urls.topRatedMoviesUrl:
      return UITestingHttpServiceMock.topRatedMovies
    default:
      return UITestingHttpServiceMock.otherMovies
    }
  }

  func getMovieDetails(for url: URL?) async throws -> MovieDetail {
    MovieDetail()
  }
}
