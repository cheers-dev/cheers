//
//  GroupsListView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct GroupsListView: View {
    @State var search = ""
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: ChatroomView()) {
                    HStack(spacing: 12) {
                        AsyncImageWithDefaultImage(imageURL: URL(string: ""))
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("Group name")
                            .fontWeight(.medium)
                        
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $search)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                DismissButton()
            }
            
            ToolbarItem(placement: .principal) {
                Text("群組列表")
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    GroupsListView()
}
