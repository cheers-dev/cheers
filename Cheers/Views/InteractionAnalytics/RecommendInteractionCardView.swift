//
//  RecommendInteractionCard.swift
//  cheers
//
//  Created by Tintin on 2024/10/21.
//

import SwiftUI

struct RecommendInteractionCardView: View {
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
                Text("上次在 ")
                    + Text(chatroomName)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.orange)
                    + Text(" 呼叫 Cheers 推薦是 ")
                    + Text(date)
                        .bold()
                        .foregroundColor(.gray)
                        
                Text("已經過了 ")
                    + Text(timePassed)
                        .bold()
                        .foregroundColor(.orange)
                        
                Text("趕快來用用 Cheers！")
            }
            .padding()
        }
    }
}

#Preview {
    RecommendInteractionCardView(
        chatroomId: UUID(uuidString: "E3426695-EE2B-4F46-BD00-D019DE9EA88B")!,
        chatroomName: "hi", date: "2024-10-24", timePassed: "3天")
}
