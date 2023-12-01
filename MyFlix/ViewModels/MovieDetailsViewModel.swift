//
//  MovieDetailsViewModel.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 30/11/2023.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
  private let httpService: HttpServiceInterface

  init(httpService: HttpServiceInterface) {
    self.httpService = httpService
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
      let result = try await httpService.getMovieDetails(for: URL(string: urlString))

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
      let movies = try await httpService.getMovies(for: URL(string: urlString))

      Task { @MainActor in
        similarMovies = movies
        similarMovies.shuffle()
      }
    } catch { }
  }
}
