//
//  UserProfileView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct UserProfileView: View {
    @AppStorage("accessTokenFound")
    var accessTokenFound = KeychainManager.getToken("accessToken") != nil
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
                    NavigationLink(destination: FoodWorldCupView()) {
                        NavigationButtonLabel(
                            systemName: "person.2.fill",
                            label: "美食世界盃"
                        )
                    }
                    Divider()
                    NavigationLink(destination: Text("好友分析")) {
                        NavigationButtonLabel(
                            systemName: "text.magnifyingglass.rtl",
                            label: "好友分析"
                        )
                    }
                    Divider()
                    NavigationLink(destination: Text("美食盛典")) {
                        NavigationButtonLabel(
                            systemName: "takeoutbag.and.cup.and.straw.fill",
                            label: "美食盛典"
                        )
                    }
                    Divider()
                    NavigationLink(destination: Text("收藏口袋")) {
                        NavigationButtonLabel(
                            systemName: "heart.fill",
                            label: "收藏口袋"
                        )
                    }
                    Divider()
                    Button(action: { logout() }) {
                        NavigationButtonLabel(
                            systemName: "rectangle.portrait.and.arrow.right",
                            label: "登出"
                        )
                        .fontWeight(.medium)
                        .foregroundStyle(.red)
                    }
                }
                .foregroundStyle(.black)
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
    
    func logout() {
        do {
            accessTokenFound = false
            try KeychainManager.deleteToken("accessToken")
        } catch(let error) {
            print(error)
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
