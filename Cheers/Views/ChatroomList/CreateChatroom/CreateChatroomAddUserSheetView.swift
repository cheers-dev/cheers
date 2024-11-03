//
//  CreateChatroomAddUserSheetView.swift
//  cheers
//
//  Created by Dong on 10/11/24.
//

import SwiftUI

struct CreateChatroomAddUserSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var members: [User]
    @State var friends: [User]

    var body: some View {
        List(friends) { user in
            Button(action: {
                members.append(user)
                dismiss()
            }) {
                HStack(spacing: 12) {
                    AsyncImageWithDefaultImage(imageURL: user.avatar)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                    Text(user.name)
                    Spacer()
                }
            }.swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive, action: {}) {
                    Image(systemName: "trash")
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("新增成員")
        .navigationBarTitleDisplayMode(.inline)
    }
}
