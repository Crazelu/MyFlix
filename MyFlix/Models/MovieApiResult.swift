//
//  MovieSearchResult.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import Foundation

struct MovieApiResult: Codable {
  let movies: [Movie]

  enum CodingKeys: String, CodingKey {
    case movies = "results"
  }
}

struct Movie: Codable {
  let id: Int
  let posterPath: String?

  enum CodingKeys: String, CodingKey {
    case id
    case posterPath = "poster_path"
  }
}
