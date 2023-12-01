//
//  AppConstants.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

enum AppConstants {
  static let horizontalPadding: CGFloat = 8

  enum Colors {
    static let backgroundColor = Color("BackgroundColor")
    static let tintColor = Color("TintColor")
  }

  enum Urls {
    static let imageBaseUrl = URL(string: "https://image.tmdb.org/t/p/original/")
    static let trendingMoviesUrl = URL(string: "https://api.themoviedb.org/3/trending/movie/week?language=en-US")
    static let movieSearchUrl = URL(string: "https://api.themoviedb.org/3/search/movie?query=")
    static let popularMoviesUrl = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")
    static let topRatedMoviesUrl = URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")
    static let upcomingMoviesUrl = URL(string: "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1")
    static let movieDetailsUrl = URL(string: "https://api.themoviedb.org/3/movie/")
    static let similarMoviesUrl = URL(string: "https://api.themoviedb.org/3/movie/")
  }

  enum Images {
    static let popcorn = "PopcornImage"
    static let search = "SearchImage"
    static let empty = "EmptyStateImage"
  }
}
