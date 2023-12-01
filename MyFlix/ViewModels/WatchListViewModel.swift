//
//  WatchListViewModel.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 30/11/2023.
//

import Foundation
import CoreData

class WatchListViewModel: ObservableObject {
  let container: NSPersistentContainer

  init(persistentStoreDescriptions: [NSPersistentStoreDescription] = []) {
    container = NSPersistentContainer(name: "MoviesContainer")
    if !persistentStoreDescriptions.isEmpty {
      container.persistentStoreDescriptions = persistentStoreDescriptions
    }
    container.loadPersistentStores { _, _ in }

    getWatchlist()
  }

  @Published var savedMovies: [MovieEntity] = []
  @Published var hasError = false
  @Published var errorMessage = ""

  func addToWatchlist(id: Int, imageUrl: String) {
    if findMovieById(id: id) != nil { return }

    let movieEntity = MovieEntity(context: container.viewContext)
    movieEntity.id = Int32(id)
    movieEntity.imageUrl = imageUrl
    save()
  }

  private func save() {
    do {
      try container.viewContext.save()
      getWatchlist()
    } catch {
      hasError = true
      errorMessage = "Failed to update your watch list\n\(error)"
    }
  }

  private func getWatchlist() {
    let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")

    do {
      savedMovies = try container.viewContext.fetch(request)
    } catch {
      hasError = true
      errorMessage = "Unable to fetch your watch list\n\(error)"
    }
  }

  func delete(id: Int) {
    guard let movieEntity = findMovieById(id: id)
    else { return }

    container.viewContext.delete(movieEntity)
    save()
  }

  func findMovieById(id: Int) -> MovieEntity? {
    return savedMovies.first { movieEntity in
      Int(movieEntity.id) == id
    }
  }
}
