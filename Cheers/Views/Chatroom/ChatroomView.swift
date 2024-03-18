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
                Button(action: {dismiss()}) {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.gray)
                }
                Text("Chatroom name")
                    .font(.title3)
                Spacer()
                NavigationLink(destination: Text("more page")) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .fontWeight(.semibold)
            .background(Color(UIColor.systemGray6))
            
            ScrollView {
                
            }
            .frame(maxHeight: .infinity)
            HStack {
                TextField("輸入訊息", text: $message)
                    .font(.footnote)
                    .clipShape(.capsule)
                    .textFieldStyle(.roundedBorder)
                Button(action: {}) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    ChatroomView()
}
