//
//  WatchListViewModelTests.swift
//  MyFlixTests
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import XCTest
import CoreData
@testable import MyFlix

final class WatchListViewModelTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var persistentStoreDescription: NSPersistentStoreDescription!

    override func setUpWithError() throws {
      persistentStoreDescription = NSPersistentStoreDescription()
      persistentStoreDescription.type = NSInMemoryStoreType
    }

  func test_addToWatchlist() {
    let viewmodel = WatchListViewModel(persistentStoreDescriptions: [persistentStoreDescription])
    XCTAssertEqual(viewmodel.savedMovies.count, 0)
    viewmodel.addToWatchlist(id: 1, imageUrl: "")
    XCTAssertEqual(viewmodel.savedMovies.count, 1)
  }

  func test_findMovieById() {
    let viewmodel = WatchListViewModel(persistentStoreDescriptions: [persistentStoreDescription])
    XCTAssertNil(viewmodel.findMovieById(id: 1))
    viewmodel.addToWatchlist(id: 1, imageUrl: "")
    XCTAssertNotNil(viewmodel.findMovieById(id: 1))
  }

  func test_delete() {
    let viewmodel = WatchListViewModel(persistentStoreDescriptions: [persistentStoreDescription])
    XCTAssertEqual(viewmodel.savedMovies.count, 0)
    viewmodel.addToWatchlist(id: 1, imageUrl: "")
    XCTAssertEqual(viewmodel.savedMovies.count, 1)
    viewmodel.delete(id: 1)
    XCTAssertEqual(viewmodel.savedMovies.count, 0)
    viewmodel.addToWatchlist(id: 3, imageUrl: "")
    viewmodel.addToWatchlist(id: 4, imageUrl: "")
    XCTAssertEqual(viewmodel.savedMovies.count, 2)
    viewmodel.delete(id: 1)
    XCTAssertEqual(viewmodel.savedMovies.count, 2)
    viewmodel.delete(id: 3)
    XCTAssertEqual(viewmodel.savedMovies.count, 1)
  }
}
