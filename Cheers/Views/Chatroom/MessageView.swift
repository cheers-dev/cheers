//
//  MessageView.swift
//  cheers
//
//  Created by Dong on 2024/5/28.
//

import SwiftUI

struct MessageView: View {
    @Binding var message: Message
    @State var isSender: Bool

    var body: some View {
        HStack {
            if isSender { Spacer() }

            Text(message.content)
                .padding(12)
                .foregroundStyle(isSender ? .white : .primary)
                .background(isSender ? .blue : .init(uiColor: .systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .circular))

            if !isSender { Spacer() }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var message = Message(id: UUID(), userId: UUID(), content: "Hello, World!", createdAt: nil)
    MessageView(message: $message, isSender: true)
}
