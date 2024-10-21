//
//  ChatInteractionCard.swift
//  cheers
//
//  Created by Tintin on 2024/10/21.
//

import SwiftUI

struct ChatInteractionCardView: View {
    let chatroomId: UUID
    let chatroomName: String
    let date: String
    let timePassed: String
    
    var body: some View {
        NavigationLink(destination: ChatroomView(chatroomVM: ChatroomVM(chatroom: Chatroom(
            id: chatroomId,
            name: chatroomName,
            avatar: nil)
        ))){
            VStack(alignment: .leading) {
                Text("上次跟 ")
                    + Text(chatroomName)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.orange)
                    + Text(" 的夥伴們互動是 ")
                + Text(date)
                    .bold()
                    .foregroundColor(.gray)
                        
                Text("已經過了 ")
                    + Text(timePassed)
                        .bold()
                        .foregroundColor(.orange)
                        
                Text("趕快傳訊息給他們吧！")
            }
            .padding()
        }
    }
}

#Preview {
    ChatInteractionCardView(
        chatroomId: UUID(uuidString: "E3426695-EE2B-4F46-BD00-D019DE9EA88B")!, chatroomName: "hi", date: "2024-10-24", timePassed: "3天")
}
