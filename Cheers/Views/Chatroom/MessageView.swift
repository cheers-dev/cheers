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
            
            VStack (alignment: .leading) {
                if !isSender {
                    Text("\(message.name)")
                        .font(.system(size: 13))
                        .padding(.horizontal, 5)
                }
                Text(message.content)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .foregroundStyle(isSender ? .white : .primary)
                    .background(isSender ? .blue : .init(uiColor: .systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
            }
            
            if !isSender { Spacer() }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 1.5)
        .frame(maxWidth: .infinity)
    }
}

//@available(iOS 18, *)
//#Preview {
//    @Previewable @State var message = Message(id: UUID(), userId: UUID(), content: "Hello, World!", createdAt: nil)
//    MessageView(message: $message, isSender: true)
//}
