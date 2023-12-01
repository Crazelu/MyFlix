//
//  ContentView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

struct ContentView: View {
  init() {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = UIColor(AppConstants.Colors.backgroundColor)
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
  }

  @EnvironmentObject var movieVM: MoviesViewModel

  var body: some View {
    TabView {
      MoviesView()
        .tabItem {
          Image("Camera")
            .resizable()
            .aspectRatio(contentMode: .fit)
          Text("Movies")
        }
      WatchListView()
        .tabItem {
          Image(systemName: "square.stack")
          Text("Watch List")
        }
      SearchView()
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
    }
    .accentColor(Color.white)
    .onAppear {
      let standardAppearance = UITabBarAppearance()
      standardAppearance.configureWithDefaultBackground()
      standardAppearance.backgroundColor = UIColor(AppConstants.Colors.backgroundColor)
      UITabBar.appearance().standardAppearance = standardAppearance

      let scrollEdgeAppearance = UITabBarAppearance()
      scrollEdgeAppearance.configureWithTransparentBackground()
      scrollEdgeAppearance.backgroundColor = UIColor(AppConstants.Colors.backgroundColor)
      UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance

      Task {
        await movieVM.getMovies()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(MoviesViewModel())
      .environmentObject(WatchListViewModel())
  }
}
