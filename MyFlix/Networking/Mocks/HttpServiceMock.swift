//
//  InitialSearchHttpServiceMock.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import Foundation

class HttpServiceMock: HttpServiceInterface {
  var movies: [Movie]
  var movieDetail: MovieDetail?
  var shouldThrowError: Bool

  init(movies: [Movie] = [], movieDetail: MovieDetail? = nil, shouldThrowError: Bool = false) {
    self.movies = movies
    self.movieDetail = movieDetail
    self.shouldThrowError = shouldThrowError
  }

  func getMovies(for url: URL?) async throws -> [Movie] {
    if shouldThrowError {
      throw HttpRequestError.requestFailed
    }
    return movies
  }

  func getMovieDetails(for url: URL?) async throws -> MovieDetail {
    if shouldThrowError {
      throw HttpRequestError.requestFailed
    }
    return movieDetail ?? MovieDetail()
  }
}
