//
//  MovieDetailsResult.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 29/11/2023.
//

import Foundation

struct MovieDetail: Codable {
  let backdropPath: String
  let id: Int
  let overview: String
  let posterPath: String
  let releaseDate: String
  let title: String
  let rating: Double

  init() {
    backdropPath = ""
    id = 1
    overview = ""
    posterPath = ""
    releaseDate = ""
    title = ""
    rating = 0.0
  }

  init(
    backdropPath: String,
    id: Int,
    overview: String,
    posterPath: String,
    releaseDate: String,
    title: String,
    rating: Double
  ) {
    self.backdropPath = backdropPath
    self.id = id
    self.overview = overview
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.title = title
    self.rating = rating
  }

  enum CodingKeys: String, CodingKey {
    case backdropPath = "backdrop_path"
    case id
    case overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case rating = "vote_average"
  }
}
