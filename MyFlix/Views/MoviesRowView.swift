//
//  MoviesRowView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

struct MoviesRowView: View {
  @EnvironmentObject var watchlistVM: WatchListViewModel

  let title: String
  let movies: [Movie]
  let proxy: GeometryProxy

  var body: some View {
    if !movies.isEmpty {
      VStack(alignment: .leading) {
        Text(title)
          .font(.title2.weight(.bold))
          .padding(.leading, AppConstants.horizontalPadding)
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(spacing: 8) {
            Color.clear
              .frame(width: AppConstants.horizontalPadding * 0.45, height: proxy.size.height * 0.3)
            ForEach(movies, id: \.id) { movie in
              NavigationLink {
                MovieDetailsView(movieId: movie.id)
              } label: {
                ImageView(imageUrl: movie.posterPath)
                  .frame(width: proxy.size.width * 0.38, height: proxy.size.height * 0.3)
                  .cornerRadius(proxy.size.width * 0.04)
              }
            }
          }
        }
      }
      .padding(.bottom, proxy.size.width * 0.03)
    }
  }
}
