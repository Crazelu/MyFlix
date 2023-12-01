//
//  MovieDetailsViewModel.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 30/11/2023.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
  private let httpService: HttpService<MovieDetail>
  private let similarMoviesHttpService: HttpService<MovieApiResult>

  init() {
    httpService = HttpService<MovieDetail>()
    similarMoviesHttpService = HttpService<MovieApiResult>()
  }

  @Published var detail: MovieDetail?
  @Published var loading = false
  @Published var hasError = false
  @Published var similarMovies: [Movie] = []

  func getMovieDetails(forId movieId: Int) async {
    Task {
      await getDetails(forId: movieId)
    }
    Task {
      await getSimilarMovies(forId: movieId)
    }
  }

  private func getDetails(forId movieId: Int) async {
    do {
      if detail != nil { return }

      Task { @MainActor in
        loading = true
        hasError = false
        similarMovies = []
      }

      defer {
        Task { @MainActor in
          loading = false
        }
      }

      // swiftlint:disable:next force_unwrapping
      let urlString = "\(AppConstants.Urls.movieDetailsUrl!.absoluteString)\(movieId)?language=en-US"
      let result = try await httpService.makeRequest(for: URL(string: urlString))

      Task { @MainActor in
        detail = result
      }
    } catch {
      Task { @MainActor in
        loading = false
        hasError = true
      }
    }
  }

  func getSimilarMovies(forId movieId: Int) async {
    do {
      if !similarMovies.isEmpty { return }
      // swiftlint:disable:next force_unwrapping
      let urlString = "\(AppConstants.Urls.similarMoviesUrl!.absoluteString)\(movieId)/similar?language=en-US&page=1"
      let result = try await similarMoviesHttpService.makeRequest(for: URL(string: urlString))

      Task { @MainActor in
        similarMovies = result.movies
        similarMovies.shuffle()
      }
    } catch { }
  }
}
