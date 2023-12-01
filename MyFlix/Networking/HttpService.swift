//
//  HttpService.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 30/11/2023.
//

import Foundation

protocol HttpServiceInterface {
  func getMovies(for url: URL?) async throws -> [Movie]
  func getMovieDetails(for url: URL?) async throws -> MovieDetail
}

class HttpService: HttpServiceInterface {
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration

  init() {
    sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.waitsForConnectivity = true
    session = URLSession(configuration: sessionConfiguration)
  }

  var token: String {
    guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist")
    else { return "" }

    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "ACCESS_TOKEN") as? String else {
      return ""
    }
    return value
  }

  private func getRequest(for url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = [ "Authorization": "Bearer \(token)" ]
    return request
  }

  func getMovies(for url: URL?) async throws -> [Movie] {
    guard let url = url
    else {
      throw HttpRequestError.malformedUrl
    }

    let request = getRequest(for: url)

    do {
      let (data, response) = try await session.data(for: request)

      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
      else {
        throw HttpRequestError.invalidResponse
      }

      return try JSONDecoder().decode(MovieApiResult.self, from: data).movies
    } catch {
      throw HttpRequestError.requestFailed
    }
  }

  func getMovieDetails(for url: URL?) async throws -> MovieDetail {
    guard let url = url
    else {
      throw HttpRequestError.malformedUrl
    }

    let request = getRequest(for: url)

    do {
      let (data, response) = try await session.data(for: request)

      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
      else {
        throw HttpRequestError.invalidResponse
      }

      return try JSONDecoder().decode(MovieDetail.self, from: data)
    } catch {
      throw HttpRequestError.requestFailed
    }
  }
}

enum HttpRequestError: Error {
  case malformedUrl
  case invalidResponse
  case requestFailed
}
