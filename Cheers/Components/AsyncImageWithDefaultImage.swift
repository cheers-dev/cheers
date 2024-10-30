//
//  AsyncImageWithDefaultImage.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct AsyncImageWithDefaultImage: View {
    let imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .scaledToFill()

                case .empty:
                    ProgressView()

                default:
                    Image("icon")
                        .resizable()
                        .padding(4)
                        .scaledToFit()
                        .background(Color(UIColor.systemGray5))
            }
        }
    }
}

#Preview {
    AsyncImageWithDefaultImage(imageURL: URL(string: ""))
}
