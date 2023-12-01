//
//  EmptyStateView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 30/11/2023.
//

import SwiftUI

struct EmptyStateView: View {
  let text: String
  let proxy: GeometryProxy
  let image: String

  init(text: String, proxy: GeometryProxy, image: String = AppConstants.Images.empty) {
    self.text = text
    self.proxy = proxy
    self.image = image
  }

  var body: some View {
    VStack {
      Image(image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: proxy.size.width * 0.4)
        .frame(height: proxy.size.height * 0.2)
      Text(text)
        .font(.headline.weight(.medium))
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
    }
  }
}
