//
//  GroupInteraction.swift
//  cheers
//
//  Created by Tintin on 2024/10/21.
//

import SwiftUI

struct GroupInteraction: View {
    @Binding var chatInteractionCards: [ChatInteractionCard]
    @Binding var recommendInteractionCards: [RecommendInteractionCard]
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack{
            header
            
            // TabView for switching between Chat and Recommend interactions
            Picker("", selection: $selectedTab) {
                Text("群組互動").tag(0)
                Text("Cheers 推薦").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            
            if selectedTab == 0 {
                // ChatInteractionCard List
                if chatInteractionCards.isEmpty {
                    Spacer()
                    ProgressView("Loading chat interactions...")
                    Spacer()
                } else {
                    List(chatInteractionCards, id: \.chatroomName) { chatInteractionCard in
                        ChatInteractionCardView(
                            chatroomId: chatInteractionCard.chatroomId,
                            chatroomName: chatInteractionCard.chatroomName,
                            date: chatInteractionCard.date,
                            timePassed: chatInteractionCard.timePassed
                        )
                        .padding(.horizontal, 5)
                    }
                    .listStyle(PlainListStyle())
                }
            } else {
                // RecommendInteractionCard List
                if recommendInteractionCards.isEmpty {
                    Spacer()
                    ProgressView("Loading Cheers history...")
                    Spacer()
                } else {
                    List(recommendInteractionCards, id: \.chatroomName) { recommendInteractionCard in
                        RecommendInteractionCardView(
                            chatroomId: recommendInteractionCard.chatroomId,
                            chatroomName: recommendInteractionCard.chatroomName,
                            date: recommendInteractionCard.date,
                            timePassed: recommendInteractionCard.timePassed
                        )
                        .padding(.horizontal, 5)
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var header: some View {
        HStack {
            DismissButton()
            Text("群組聚聚")
                .font(.title3)
            Spacer()
        }
        .padding()
        .fontWeight(.semibold)
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .top)
    }
}

//#Preview {
//}
