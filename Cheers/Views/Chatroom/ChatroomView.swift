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
    @State var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            HStack {
                DismissButton()
                Text(chatroomVM.chatroom.name)
                    .font(.title3)
                Spacer()
                NavigationLink(destination: ChatroomSettingsView()) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .fontWeight(.semibold)
            .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .top)
            
            ScrollView {
                ForEach(chatroomVM.messages.sorted(by: { $0.createdAt! < $1.createdAt! })) { message in
                    Text(message.content)
                }
            }
            .frame(maxHeight: .infinity)
            
            HStack {
                TextField("輸入訊息", text: $message)
                    .font(.footnote)
                    .clipShape(.capsule)
                    .textFieldStyle(.roundedBorder)
                
                if(!message.isEmpty) {
                    Button(action: { chatroomVM.sendMessage(message) }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
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

#Preview {
    ChatroomView(chatroomVM: ChatroomVM(chatroom: Chatroom(
        id: UUID(uuidString: "E3426695-EE2B-4F46-BD00-D019DE9EA88B")!,
        name: "testing",
        avatar: nil)
    ))
}
