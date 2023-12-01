//
//  HttpService.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 30/11/2023.
//

import Foundation

class HttpService<T: Decodable> {
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration

  init() {
    sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.waitsForConnectivity = true
    session = URLSession(configuration: sessionConfiguration)
  }

  var token: String {
    guard let url = Bundle.main.url(forResource: "api", withExtension: "json")
    else { return "" }

    do {
      let api = try JSONDecoder().decode(Api.self, from: try Data(contentsOf: url))
      return api.token
    } catch { return "" }
  }

  private func getRequest(for url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = [ "Authorization": "Bearer \(token)" ]
    return request
  }

  func makeRequest(for url: URL?) async throws -> T {
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

      return try JSONDecoder().decode(T.self, from: data)
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
