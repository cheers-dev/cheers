//
//  ChatroomView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct ChatroomView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var message = ""
    
    var body: some View {
        NavigationStack {
            HStack {
                DismissButton()
                Text("Chatroom name")
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
                
            }
            .frame(maxHeight: .infinity)
            HStack {
                TextField("輸入訊息", text: $message)
                    .font(.footnote)
                    .clipShape(.capsule)
                    .textFieldStyle(.roundedBorder)
                
                if(!message.isEmpty) {
                    Button(action: {}) {
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
    }
}

#Preview {
    ChatroomView()
}
