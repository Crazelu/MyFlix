//
//  MovieDetailsView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

struct MovieDetailsView: View {
  let movieId: Int

  @StateObject var movieDetailsVM = MovieDetailsViewModel(httpService: HttpService())

  var body: some View {
    GeometryReader { proxy in
      ZStack {
        AppConstants.Colors.backgroundColor
          .edgesIgnoringSafeArea(.all)
        if movieDetailsVM.loading {
          ProgressView()
            .controlSize(.large)
            .tint(.accentColor)
        }
        if movieDetailsVM.hasError {
          ErrorView(proxy: proxy, movieId: movieId)
        }
        if movieDetailsVM.detail != nil {
          VStack {
            // swiftlint:disable:next force_unwrapping
            DetailsSubView(detail: movieDetailsVM.detail!, proxy: proxy)
          }
        }
      }
    }
    .environmentObject(movieDetailsVM)
    .foregroundColor(.white)
    .navigationBarBackButtonHidden(movieDetailsVM.detail != nil)
    .accentColor(AppConstants.Colors.tintColor)
    .onAppear {
      Task {
        await movieDetailsVM.getMovieDetails(forId: movieId)
      }
    }
  }
}

struct ErrorView: View {
  let proxy: GeometryProxy
  let movieId: Int

  @EnvironmentObject private var movieDetailsVM: MovieDetailsViewModel

  var body: some View {
    VStack {
      EmptyStateView(
        text: "Failed to retrieve movie details",
        proxy: proxy
      )
      Button {
        Task {
          await movieDetailsVM.getMovieDetails(forId: movieId)
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
}

struct DetailsSubView: View {
  let detail: MovieDetail
  let proxy: GeometryProxy

  // swiftlint:disable:next attributes
  @Environment(\.presentationMode) private var presentation
  // swiftlint:disable:next attributes
  @Environment(\.fromWatchList) private var fromWatchlist

  @EnvironmentObject private var movieDetailsVM: MovieDetailsViewModel
  @EnvironmentObject private var watchlistVM: WatchListViewModel
  @State private var animateGrid = false
  @State private var animateTitle = false
  @State private var animateTextRow = false
  @State private var animateOverview = false

  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  var isMovieInWatchlist: Bool {
    watchlistVM.findMovieById(id: detail.id) != nil
  }

  var body: some View {
    VStack {
      ZStack {
        ImageView(imageUrl: detail.backdropPath)
          .frame(width: proxy.size.width)
          .edgesIgnoringSafeArea(.top)
        Image(systemName: "xmark")
          .frame(width: proxy.size.width * 0.12, height: proxy.size.width * 0.12)
          .background(Color.black.opacity(0.7))
          .cornerRadius(proxy.size.width * 0.12)
          .offset(x: proxy.size.width * 0.42, y: -proxy.size.height * 0.12)
          .onTapGesture {
            presentation.wrappedValue.dismiss()
          }
      }
      .frame(maxHeight: proxy.size.height * 0.35)
      .onAppear {
        Task {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.spring()) {
              animateTitle = true
            }
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring()) {
              animateTextRow = true
            }
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring()) {
              animateOverview = true
            }
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.spring()) {
              animateGrid = true
            }
          }
        }
      }

      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          Text(detail.title)
            .font(.title.weight(.semibold))
            .padding(.bottom, proxy.size.height * 0.002)
            .padding(.top, proxy.size.height * 0.02)
            .offset(y: animateTitle ? 0 : proxy.size.height)
          HStack {
            Text(detail.releaseDate[...String.Index(utf16Offset: 3, in: detail.releaseDate)])
              .foregroundColor(Color.white.opacity(0.8))
            Text("•")
              .fontWeight(.bold)
              .foregroundColor(.gray)
            Text("\(String(format: "%.2f", detail.rating))/10")
              .fontWeight(.semibold)
              .foregroundColor(Color.accentColor.opacity(0.8))
            Text("on IMDB")
              .foregroundColor(Color.white.opacity(0.8))
          }
          .padding(.bottom, proxy.size.height * 0.01)
          .offset(y: animateTextRow ? 0 : proxy.size.height)

          Text(detail.overview)
            .foregroundColor(Color.white.opacity(0.9))
            .padding(.bottom, proxy.size.height * 0.015)
            .offset(y: animateOverview ? 0 : proxy.size.height)

          Button {
            withAnimation(.spring()) {
              if isMovieInWatchlist {
                watchlistVM.delete(id: detail.id)
                if fromWatchlist {
                  presentation.wrappedValue.dismiss()
                }
              } else {
                watchlistVM.addToWatchlist(id: detail.id, imageUrl: detail.posterPath)
              }
            }
          } label: {
            HStack {
              Image(systemName: fromWatchlist ? "minus.circle" : isMovieInWatchlist ? "checkmark" : "plus")
              Text(fromWatchlist ? "Remove From List" : "My List")
            }
            .padding(12)
            .overlay {
              RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.7))
            }
          }
          .padding(.bottom, proxy.size.height * 0.025)
          .offset(y: animateOverview ? 0 : proxy.size.height)


          if !movieDetailsVM.similarMovies.isEmpty {
            Text("Similar Movies")
              .font(.headline.weight(.bold))
              .offset(y: animateGrid ? 0 : proxy.size.height)
            LazyVGrid(columns: columns) {
              ForEach(movieDetailsVM.similarMovies, id: \.id) { movie in
                NavigationLink {
                  MovieDetailsView(movieId: movie.id)
                } label: {
                  ImageView(imageUrl: movie.posterPath)
                    .frame(width: proxy.size.width * 0.32)
                    .frame(height: proxy.size.height * 0.28)
                    .cornerRadius(proxy.size.width * 0.02)
                }
              }
            }
            .offset(y: animateGrid ? 0 : proxy.size.height)
          }
        }
        .padding(.horizontal, AppConstants.horizontalPadding)
      }
    }
  }
}

struct MovieDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    MovieDetailsView(movieId: 1)
  }
}
