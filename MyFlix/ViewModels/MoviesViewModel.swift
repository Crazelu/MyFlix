//
//  MoviesStore.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

class MoviesViewModel: ObservableObject {
  private let httpService: HttpServiceInterface

  init(httpService: HttpServiceInterface) {
    self.httpService = httpService
  }

  @Published var upcomingMovies: [Movie] = []
  @Published var topRatedMovies: [Movie] = []
  @Published var popularMovies: [Movie] = []
  @Published var trendingMovies: [Movie] = []
  @Published var loadingMovies = false
  @Published var hasErrorLoadingMovies = false
  var errorCount = 0

  private func getUpcomingMovies() async throws {
    let movies = try await httpService.getMovies(for: AppConstants.Urls.upcomingMoviesUrl)
    Task { @MainActor in
      upcomingMovies = movies
      upcomingMovies.shuffle()
    }
  }

  private func getTopRatedMovies() async throws {
    let movies = try await httpService.getMovies(for: AppConstants.Urls.topRatedMoviesUrl)
    Task { @MainActor in
      topRatedMovies = movies
      topRatedMovies.shuffle()
    }
  }

  private func getPopularMovies() async throws {
    let movies = try await httpService.getMovies(for: AppConstants.Urls.popularMoviesUrl)
    Task { @MainActor in
      popularMovies = movies
      popularMovies.shuffle()
    }
  }

  private func getTrendingMovies() async throws {
    let movies = try await httpService.getMovies(for: AppConstants.Urls.trendingMoviesUrl)
    Task { @MainActor in
      trendingMovies = movies
      trendingMovies.shuffle()
    }
  }

  private func updateErrorCount() {
    errorCount += 1
    if errorCount >= 4 {
      Task { @MainActor in
        hasErrorLoadingMovies = true
      }
    }
  }

  func getMovies() async {
    errorCount = 0

    Task { @MainActor in
      hasErrorLoadingMovies = false
      loadingMovies = true
    }
    Task {
      defer {
        Task { @MainActor in
          loadingMovies = false
        }
      }

      do {
        try await getUpcomingMovies()
      } catch {
        updateErrorCount()
      }
    }

    Task {
      defer {
        Task { @MainActor in
          loadingMovies = false
        }
      }

      do {
        try await getTopRatedMovies()
      } catch {
        updateErrorCount()
      }
    }

    Task {
      defer {
        Task { @MainActor in
          loadingMovies = false
        }
      }

      do {
        try await getPopularMovies()
      } catch {
        updateErrorCount()
      }
    }

    Task {
      defer {
        Task { @MainActor in
          loadingMovies = false
        }
      }

      do {
        try await getTrendingMovies()
      } catch {
        updateErrorCount()
      }
    }
  }
}
