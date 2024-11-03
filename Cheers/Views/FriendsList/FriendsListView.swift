//
//  FriendsListView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct FriendsListView: View {
    @ObservedObject var friendsListVM: FriendsListVM
    @State var search = ""
    @State var showErrorAlert = false

    var body: some View {
        NavigationStack {
            List {
                navigationCard(destination: FriendInvitationsView(friendInvitationVM: FriendInvitationsVM()),
                               icon: "plus",
                               label: "好友申請")

                navigationCard(destination: GroupsListView(vm: GroupsListVM()),
                               icon: "person.2.fill",
                               label: "Groups")

                ForEach($friendsListVM.friends) { friend in
                    NavigationLink(destination: Text("User Analysis")) {
                        UserAvatarWithName(user: friend)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("好友列表")
            .searchable(text: $search)
            .onReceive(friendsListVM.$error) { error in
                if error != nil {
                    showErrorAlert.toggle()
                }
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button(action: { showErrorAlert.toggle() }) {
                    Text("OK")
                }
            } message: {
                if friendsListVM.error != nil {
                    Text(String(describing: friendsListVM.error!))
                }
            }
        }
    }

    func navigationCard(destination: some View, icon: String, label: String) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 12) {
                Circle()
                    .stroke(Color(UIColor.systemGray4))
                    .frame(width: 50, height: 50)
                    .overlay {
                        Image(systemName: icon)
                            .font(.title2)
                    }
                Text(label)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    FriendsListView(friendsListVM: FriendsListVM())
}
