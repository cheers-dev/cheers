//
//  ChatroomSettingsView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct ChatroomSettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {}) {
                    VStack(spacing: 4) {
                        Image(systemName: "person.2.fill")
                            .font(.title)
                        Text("成員")
                    }
                }
                Spacer()
                Button(action: {}) {
                    VStack(spacing: 4) {
                        Image(systemName: "person.fill.badge.plus")
                            .font(.title)
                        Text("邀請")
                    }
                }
                Spacer()
                Button(action: {}) {
                    VStack(spacing: 4) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.title)
                        Text("邀請")
                    }
                }
                Spacer()
            }
            .padding()
            .font(.footnote)

            Divider()

            VStack(alignment: .leading, spacing: 20) {
                Button(action: {}) {
                    HStack {
                        Label("更改群組名稱", systemImage: "pencil.line")
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .font(.footnote)
                    }
                }
                
                Divider()
                
                Button(action: {}) {
                    Label("更改群組頭貼", systemImage: "photo")
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.footnote)
                }
                
                Divider()
                
                Button(action: {}) {
                    Label("刪除群組", systemImage: "trash.fill")
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.footnote)
                }
                .foregroundStyle(.red)
            }
            .padding(20)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.gray)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Chatroom name")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .foregroundStyle(.black)
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    ChatroomSettingsView()
}
