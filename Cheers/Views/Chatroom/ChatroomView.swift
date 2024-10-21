//
//  ChatroomView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct ChatroomView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var chatroomVM: ChatroomVM
    
    @State var message = ""
    @State var lastLoadMessage: Message?
    @State var showErrorAlert = false
    
    var userId = KeychainManager.getToken("userId")
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                if chatroomVM.loading {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                } else {
                    chatMessages
                }
                footer
            }
            .navigationBarBackButtonHidden()
            .scrollDismissesKeyboard(.interactively)
            .toolbar(.hidden, for: .tabBar)
            .onReceive(chatroomVM.$error) { error in
                if error != nil {
                    showErrorAlert.toggle()
                }
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button(action: { showErrorAlert.toggle() }) {
                    Text("OK")
                }
            } message: {
                if chatroomVM.error != nil {
                    Text(String(describing: chatroomVM.error!))
                }
            }
        }
    }
    
    var header: some View {
        HStack {
            DismissButton()
            Text(chatroomVM.chatroom.name)
                .font(.title3)
            Spacer()
            NavigationLink(destination: RecommendationListView(recommendations: $chatroomVM.recommendations
            )){
                Image(systemName: "lightbulb.fill")
                    .font(.title3)
                    .foregroundStyle($chatroomVM.recommendations.isEmpty ? .black : .yellow)
            }
            .padding(.horizontal, 8)
            NavigationLink(destination: ChatroomSettingsView()) {
                Image(systemName: "line.horizontal.3")
                    .font(.title3)
                    .foregroundStyle(.black)
            }
        }
        .padding()
        .fontWeight(.semibold)
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .top)
        .onAppear {
            Task {
                let recommendations = await chatroomVM.fetchRecommendations()
                chatroomVM.recommendations = recommendations
            }
        }
    }
    
    var chatMessages: some View {
        ScrollViewReader { scrollView in
            ScrollView {
                LazyVStack {
                    if chatroomVM.hasMore {
                        ProgressView()
                            .padding(.vertical, 8)
                        .onAppear {
                            chatroomVM.loadMessages()
                        }
                    }
                    
                    ForEach($chatroomVM.messages, id: \.id) { message in
                        MessageView(
                            message: message,
                            isSender: userId == message.wrappedValue.userId.uuidString
                        )
                        .id(message.id)
                    }
                    .onAppear {
                        if let id = chatroomVM.messages.last?.id {
                            withAnimation {
                                scrollView
                                    .scrollTo(id, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .contentMargins(.vertical, 8)
            .onReceive(chatroomVM.messages.publisher) { _ in
                if let lastMessage = chatroomVM.messages.last,
                   lastMessage.id != lastLoadMessage?.id,
                   lastMessage.userId.uuidString == userId {
                    withAnimation {
                        scrollView
                            .scrollTo(chatroomVM.messages.last?.id, anchor: .bottom)
                    }
                }
                
                lastLoadMessage = chatroomVM.messages.last
            }
        }
    }
    
    var footer: some View {
        HStack {
            TextField("輸入訊息", text: $message)
                .font(.footnote)
                .clipShape(.capsule)
                .textFieldStyle(.roundedBorder)
            
            if(!message.isEmpty) {
                Button(action: {
                    chatroomVM.sendMessage(message)
                    message = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))

    }
}

#Preview {
    ChatroomView(chatroomVM: ChatroomVM(chatroom: Chatroom(
        id: UUID(uuidString: "E3426695-EE2B-4F46-BD00-D019DE9EA88B")!,
        name: "testing",
        avatar: nil)
    ))
}
