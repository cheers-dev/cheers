//
//  FriendListCardView.swift
//  cheers
//
//  Created by Dong on 2024/7/17.
//

import SwiftUI


struct FriendListCardView: View {
    @Binding var user: User
    
    var body: some View {
        NavigationLink(destination: Text("user detail page")) {
            HStack(spacing: 12) {
                AsyncImageWithDefaultImage(imageURL: user.avatar)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text(user.name)
                    .fontWeight(.medium)
                
            }
        }
    }
}
