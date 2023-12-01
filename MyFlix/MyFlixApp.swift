//
//  MyFlixApp.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

@main
struct MyFlixApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(MoviesViewModel())
        .environmentObject(WatchListViewModel())
    }
  }
}
