//
//  FriendsListView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct FriendsListView: View {
    @ObservedObject var viewModel: FriendsListVM
    @State var search = ""
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: FriendInvitationsView()) {
                    HStack(spacing: 12) {
                        Circle()
                            .stroke(Color(UIColor.systemGray4))
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "plus")
                                    .font(.title2)
                            }
                        Text("好友申請")
                            .fontWeight(.medium)
                    }
                }
                
                NavigationLink(destination: GroupsListView()) {
                    HStack(spacing: 12) {
                        Circle()
                            .stroke(Color(UIColor.systemGray4))
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "person.2.fill")
                                    .font(.title2)
                            }
                        Text("Groups")
                            .fontWeight(.medium)
                    }
                }
                
                ForEach($viewModel.friends) { friend in
                    FriendListCardView(user: friend)
                }
            }
            .listStyle(.plain)
            .navigationTitle("好友列表")
            .searchable(text: $search)
        }
    }
}

#Preview {
    FriendsListView(viewModel: FriendsListVM())
}
