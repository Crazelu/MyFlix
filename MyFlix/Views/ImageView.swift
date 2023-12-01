//
//  MovieCardView.swift
//  MyFlix
//
//  Created by LUCKY EBERE on 28/11/2023.
//

import SwiftUI

struct ImageView: View {
  let imageUrl: String?

  var url: String {
    (AppConstants.Urls.imageBaseUrl?.absoluteString ?? "") + (imageUrl ?? "")
  }

  var body: some View {
    AsyncImage(url: URL(string: url)) { image in
      image.resizable()
        .aspectRatio(contentMode: .fill)
    } placeholder: {
      ZStack {
        Color.gray.opacity(0.2)
        ProgressView()
      }
    }
  }
}

struct ImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageView(imageUrl: "")
  }
}
