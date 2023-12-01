//
//  WatchListView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

struct WatchListView: View {
  @EnvironmentObject var watchlistVM: WatchListViewModel

  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  var body: some View {
    NavigationStack {
      GeometryReader { proxy in
        ZStack {
          AppConstants.Colors.backgroundColor
            .ignoresSafeArea()
          if watchlistVM.savedMovies.isEmpty {
            EmptyStateView(
              text: "It's quiet in here...",
              proxy: proxy,
              image: AppConstants.Images.popcorn
            )
          }
          if !watchlistVM.savedMovies.isEmpty {
            ScrollView {
              LazyVGrid(columns: columns) {
                ForEach(watchlistVM.savedMovies, id: \.id) { movie in
                  NavigationLink {
                    MovieDetailsView(movieId: Int(movie.id))
                  } label: {
                    ImageView(imageUrl: movie.imageUrl)
                      .frame(width: proxy.size.width * 0.32)
                      .frame(height: proxy.size.height * 0.28)
                      .cornerRadius(proxy.size.width * 0.02)
                  }
                }
              }
            }
            .padding(.horizontal, AppConstants.horizontalPadding)
          }
        }
        .navigationTitle("My Watch List")
      }
      .alert("Something Went Wrong", isPresented: $watchlistVM.hasError, actions: {
        Button("Got it") {
          watchlistVM.hasError.toggle()
        }
      }, message: {
        Text(watchlistVM.errorMessage)
      })
    }
    .environment(\.fromWatchList, true)
  }
}

struct WatchListView_Previews: PreviewProvider {
  static var previews: some View {
    WatchListView()
  }
}
