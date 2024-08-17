//
//  ChatroomSettingsView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct ChatroomSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ChatroomSettingsVM
    
    @State var showMembers: Bool = false
    @State var showInvite: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Spacer()
                Button(action: { showMembers = true }) {
                    VStack(spacing: 4) {
                        Image(systemName: "person.2.fill")
                            .font(.title)
                        Text("成員")
                    }
                }
                Spacer()
                Button(action: { showInvite = true }) {
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
                        Text("離開")
                    }
                }
                Spacer()
            }
            .padding()
            .font(.footnote)

            Divider()

            VStack(alignment: .leading, spacing: 20) {
                Button(action: {}) {
                    NavigationButtonLabel(
                        systemName: "pencil.line",
                        label: "更改群組名稱"
                    )
                }
                
                Divider()
                
                Button(action: {}) {
                    NavigationButtonLabel(
                        systemName: "photo",
                        label: "更改群組頭貼"
                    )
                }
                
                Divider()
                
                Button(action: {}) {
                    NavigationButtonLabel(
                        systemName: "trash.fill",
                        label: "刪除群組")
                }
                .foregroundStyle(.red)
            }
            .padding(20)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding()
        .foregroundStyle(.black)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .all)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                DismissButton()
            }
            
            ToolbarItem(placement: .principal) {
                Text("Chatroom name")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .sheet(isPresented: $showMembers) {
            Text("Members")
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showInvite) { inviteSheet }
        
    }
    
    var inviteSheet: some View {
        viewModel.getFriends()
        return NavigationView {
            List($viewModel.friends) { $friend in
                HStack {
                    UserAvatarWithName(user: $friend)
                    Spacer()
                    
                    Button(action: {}) {
                        Text("邀請")
                    }.buttonStyle(.bordered)
                }
            }
            .navigationTitle("Invite")
            .navigationBarTitleDisplayMode(.inline)
        }
        .listStyle(.plain)
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    ChatroomSettingsView(viewModel: ChatroomSettingsVM())
}
