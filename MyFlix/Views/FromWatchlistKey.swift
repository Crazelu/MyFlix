//
//  FromWatchlistKey.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import SwiftUI

private struct FromWatchlistKey: EnvironmentKey {
  static let defaultValue = false
}

extension EnvironmentValues {
  var fromWatchList: Bool {
    get { self[FromWatchlistKey.self] }
    set { self[FromWatchlistKey.self] = newValue }
  }
}
