//
//  MyFlixApp.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

@main
struct MyFlixApp: App {
  let httpService: HttpServiceInterface
  // swiftlint:disable:next attributes
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  init() {
    #if DEBUG
    if UITestingHelper.isUITesting {
      httpService = UITestingHttpServiceMock(shouldThrowError: !UITestingHelper.isNetworkingSuccessful)
    } else {
      httpService = HttpService()
    }
    #else
    httpService = HttpService()
    #endif
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(MoviesViewModel(httpService: httpService))
        .environmentObject(WatchListViewModel())
    }
  }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    #if DEBUG
    print("RUNNING IN TEST MODE: \(UITestingHelper.isUITesting)")
    #endif
    return true
  }
}
