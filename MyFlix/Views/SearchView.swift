//
//  SearchView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

struct SearchView: View {
  @EnvironmentObject var moviesVM: MoviesViewModel
  @StateObject var searchVM = SearchViewModel()
  @State var searchText = ""

  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  let debouncer = Debouncer(delay: 0.5)

  func search() {
    debouncer.debounce {
      Task {
        await searchVM.search(with: searchText)
      }
    }
  }

  var body: some View {
    NavigationStack {
      GeometryReader { proxy in
        ZStack {
          AppConstants.Colors.backgroundColor.ignoresSafeArea()
          if searchVM.loading {
            ProgressView()
              .controlSize(.large)
              .tint(.accentColor)
          }
          if searchVM.hasEmptyResult {
            EmptyStateView(
              text: "No movie found for '\(searchText)'",
              proxy: proxy
            )
          }
          if !searchVM.loading && searchVM.movies.isEmpty && !searchVM.hasEmptyResult {
            EmptyStateView(
              text: "Let's find you a movie!",
              proxy: proxy,
              image: AppConstants.Images.search
            )
          }
          if !searchVM.loading && !searchVM.movies.isEmpty && !searchVM.hasError {
            ScrollView {
              LazyVGrid(columns: columns) {
                ForEach(searchVM.movies, id: \.id) { movie in
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
            }
            .padding(.top, 20)
            .padding(.horizontal, AppConstants.horizontalPadding)
          }
        }
        .navigationBarTitleDisplayMode(.inline)
      }
      .onChange(of: searchText, perform: { _ in
        search()
      })
      .accentColor(AppConstants.Colors.tintColor)
      .toolbar {
        ToolbarItem(placement: .principal) {
          CustomSearchBar(searchText: $searchText)
        }
      }
    }
  }
}

struct CustomSearchBar: View {
  @Binding var searchText: String

  var body: some View {
    HStack {
      HStack {
        Image(systemName: "magnifyingglass").foregroundColor(.gray)
        TextField("Search", text: $searchText)
          .tint(Color.gray)
          .foregroundColor(Color.white)
        if !searchText.isEmpty {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.gray)
            .onTapGesture {
              searchText = ""
            }
        }
      }
      .padding(10)
      .background(Color.black.opacity(0.2))
      .cornerRadius(10)
      .padding(.horizontal, 8)
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static let moviesVM = MoviesViewModel()
  static var previews: some View {
    SearchView()
      .environmentObject(moviesVM)
      .onAppear {
        Task {
          await moviesVM.getMovies()
        }
      }
  }
}
