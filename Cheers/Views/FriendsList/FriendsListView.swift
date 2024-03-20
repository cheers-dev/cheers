//
//  FriendsListView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct FriendsListView: View {
    @State var search = ""
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: Text("group")) {
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
                
                NavigationLink(destination: ChatroomView()) {
                    HStack(spacing: 12) {
                        AsyncImageWithDefaultImage(imageURL: URL(string: ""))
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("User name")
                            .fontWeight(.medium)
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("好友列表")
            .searchable(text: $search)
        }
    }
}

#Preview {
    FriendsListView()
}
