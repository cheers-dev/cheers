//
//  ChatroomCardView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct ChatroomCardView: View {
    let imageURL: URL?
    let name: String
    var lastMessage: Message?
    var time: Date?
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: imageURL) { res in
                switch res {
                    case .success(let image):
                        image
                            .resizable()
                    default:
                        Image("icon")
                            .resizable()
                            .padding(4)
                            .background(Color(UIColor.systemGray5))
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HStack {
                    Text(name)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(time?.formatted(date: .omitted, time: .shortened) ?? "")
                        .font(.footnote)
                }
                Text(lastMessage?.message ?? "")
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ChatroomCardView(
        imageURL: URL(string: ""),
        name: "Name",
        lastMessage: nil,
        time: Date()
    )
}
