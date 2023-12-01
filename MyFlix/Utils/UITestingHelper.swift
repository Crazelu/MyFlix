//
//  UITestingHelper.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 01/12/2023.
//

import Foundation

struct UITestingHelper {
  static var isUITesting: Bool {
    ProcessInfo.processInfo.arguments.contains("-ui-testing")
  }

  static var isNetworkingSuccessful: Bool {
    ProcessInfo.processInfo.arguments.contains("-networking-success")
  }
}
