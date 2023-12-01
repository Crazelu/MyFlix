//
//  MoviesVMHttpServiceMock.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import Foundation

class MoviesVMHttpServiceMock: HttpServiceInterface {
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

  func getMovies(for url: URL?) async throws -> [Movie] {
    if shouldThrowError {
      throw HttpRequestError.requestFailed
    }

    switch url {
    case AppConstants.Urls.trendingMoviesUrl:
      return MoviesVMHttpServiceMock.trendingMovies
    case AppConstants.Urls.upcomingMoviesUrl:
      return MoviesVMHttpServiceMock.upcomingMovies
    case AppConstants.Urls.popularMoviesUrl:
      return MoviesVMHttpServiceMock.popularMovies
    case AppConstants.Urls.topRatedMoviesUrl:
      return MoviesVMHttpServiceMock.topRatedMovies
    default:
      return []
    }
  }

  func getMovieDetails(for url: URL?) async throws -> MovieDetail {
    MovieDetail()
  }
}
