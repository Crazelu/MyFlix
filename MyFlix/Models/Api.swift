//
//  Api.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import Foundation

struct Api: Decodable {
  let token: String

  enum CodingKeys: String, CodingKey {
    case token
  }
}
