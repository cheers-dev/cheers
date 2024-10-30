//
//  MessageView.swift
//  cheers
//
//  Created by Dong on 2024/5/28.
//

import SwiftUI

// MARK: - Constants

private enum Constants {
    static let messagePadding: CGFloat = 12
    static let cornerRadius: CGFloat = 24
}

// MARK: - MessageView

struct MessageView: View {
    @Binding var message: Message
    @State var isSender: Bool

    var body: some View {
        HStack {
            if isSender { Spacer() }

            Text(message.content)
                .padding(Constants.messagePadding)
                .foregroundStyle(isSender ? .white : .primary)
                .background(isSender ? .blue : .init(uiColor: .systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .circular))

            if !isSender { Spacer() }
        }
        .padding(.horizontal, Constants.messagePadding)
        .frame(maxWidth: .infinity)
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var message = Message(id: UUID(), userId: UUID(), content: "Hello, World!", createdAt: nil)
    MessageView(message: $message, isSender: true)
}
