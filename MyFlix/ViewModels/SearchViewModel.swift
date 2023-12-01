//
//  SearchViewModel.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 30/11/2023.
//

import Foundation

class SearchViewModel: ObservableObject {
  private let httpService: HttpServiceInterface


  init(httpService: HttpServiceInterface) {
    self.httpService = httpService
    performInitialSearch()
  }

  @Published var movies: [Movie] = []
  @Published var loading = false
  @Published var hasError = false
  @Published var hasEmptyResult = false

  private func performInitialSearch() {
    Task {
      await search(with: AppConstants.initialSearchQuery)
    }
  }

  func search(with query: String) async {
    if query.isEmpty {
      Task { @MainActor in
        movies = []
        hasError = false
        loading = false
        hasEmptyResult = false
      }
      performInitialSearch()
      return
    }

    do {
      Task { @MainActor in
        loading = true
        movies = []
        hasError = false
        hasEmptyResult = false
      }

      defer {
        Task { @MainActor in
          loading = false
        }
      }

      let urlSafeQuery = query.replacingOccurrences(of: " ", with: "%20")

      // swiftlint:disable:next force_unwrapping
      let urlString = AppConstants.Urls.movieSearchUrl!.absoluteString
      + urlSafeQuery + "&include_adult=false&language=en-US&page=1"

      let result = try await httpService.getMovies(for: URL(string: urlString))
      Task { @MainActor in
        movies = result.filter { movie in
          movie.posterPath != nil
        }
        hasEmptyResult = movies.isEmpty
      }
    } catch {
      Task { @MainActor in
        hasError = true
      }
    }
  }
}
