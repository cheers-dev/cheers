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
            AsyncImageWithDefaultImage(imageURL: imageURL)
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            chatroomContent
        }
    }

    private var chatroomContent: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .fontWeight(.semibold)
                Spacer()
                dynamicTime.font(.footnote)
            }

            Text(lastMessage?.content ?? "")
                .lineLimit(2)
                .font(.callout)
                .foregroundStyle(.gray)
        }
    }

    private var dynamicTime: some View {
        Group {
            if time != nil {
                time!.timeIntervalSinceNow < -86400
                    ? Text(time!.formatted(date: .abbreviated, time: .omitted))
                    : Text(time!.formatted(date: .omitted, time: .shortened))
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
