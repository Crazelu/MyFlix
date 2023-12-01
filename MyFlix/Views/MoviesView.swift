//
//  HomeView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

struct MoviesView: View {
  @EnvironmentObject var moviesVM: MoviesViewModel

  var body: some View {
    NavigationStack {
      GeometryReader { proxy in
        ZStack {
          AppConstants.Colors.backgroundColor
            .edgesIgnoringSafeArea(.all)
          if moviesVM.loadingMovies {
            ProgressView()
              .controlSize(.large)
              .tint(.accentColor)
          }
          if moviesVM.hasErrorLoadingMovies {
            VStack {
              EmptyStateView(
                text: "Failed to fetch movies",
                proxy: proxy
              )
              Button {
                Task {
                  await moviesVM.getMovies()
                }
              } label: {
                Text("Retry")
                  .font(.subheadline)
                  .frame(maxWidth: proxy.size.width * 0.25)
                  .padding(proxy.size.width * 0.025)
                  .background(Color.accentColor)
                  .cornerRadius(proxy.size.width * 0.05)
              }
            }
          }
          if !moviesVM.loadingMovies && !moviesVM.hasErrorLoadingMovies {
            ScrollView(.vertical, showsIndicators: false) {
              LazyVStack {
                MoviesRowView(
                  title: "Trending",
                  movies: moviesVM.trendingMovies,
                  proxy: proxy
                )
                MoviesRowView(
                  title: "Top Rated",
                  movies: moviesVM.topRatedMovies,
                  proxy: proxy
                )
                MoviesRowView(
                  title: "Popular",
                  movies: moviesVM.popularMovies,
                  proxy: proxy
                )
                MoviesRowView(
                  title: "Coming Soon",
                  movies: moviesVM.upcomingMovies,
                  proxy: proxy
                )
              }
            }
            .navigationBarTitleDisplayMode(.inline)
          }
        }
        .foregroundColor(Color.white)
      }
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("MyFlix")
            .font(.title3.weight(.semibold))
            .foregroundColor(.accentColor)
        }
      }
    }
    .accentColor(AppConstants.Colors.tintColor)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    MoviesView()
      .environmentObject(MoviesViewModel())
  }
}
