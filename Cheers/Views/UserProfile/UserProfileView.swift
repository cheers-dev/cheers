//
//  UserProfileView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct UserProfileView: View {
    let avatarURL: URL?
    let name: String
    let birth: Date
    let recentFavorite: [String]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                VStack {
                    AsyncImage(url: avatarURL) { phase in
                        switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .scaledToFill()
                            default:
                                Image("icon")
                                    .resizable()
                        }
                    }
                    .padding(12)
                    .frame(width: 100, height: 100)
                    .background(Color(UIColor.systemGray4))
                    .clipShape(Circle())
                    
                    Text(name)
                        .font(.title2)
                    Label(birth.formatted(date: .numeric, time: .omitted), systemImage: "birthday.cake.fill")
                        .font(.footnote)
                }
                VStack {
                    Text("最近喜歡吃")
                        .font(.footnote)
                    Text(recentFavorite.joined(separator: ", "))
                        .padding()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    NavigationLink(destination: Text("美食世界盃")) {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .font(.title2)
                            Text("美食世界盃")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                    }
                    Divider()
                    NavigationLink(destination: Text("好友分析")) {
                        HStack {
                            Image(systemName: "text.magnifyingglass.rtl")
                                .font(.title2)
                            Text("好友分析")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                    }
                    Divider()
                    NavigationLink(destination: Text("美食盛典")) {
                        HStack {
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                .font(.title2)
                            Text("美食盛典")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                    }
                    Divider()
                    NavigationLink(destination: Text("收藏口袋")) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.title2)
                            Text("收藏口袋")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                    }
                }
                .foregroundStyle(.black)
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    UserProfileView(
        avatarURL: URL(string: ""),
        name: "User",
        birth: Date(),
        recentFavorite: ["燒肉", "火鍋", "漢堡"]
    )
}
