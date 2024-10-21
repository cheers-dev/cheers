//
//  FoodWorldCupView.swift
//  cheers
//
//  Created by 楊晏禎 on 2024/9/12.
//

import SwiftUI

struct FoodWorldCupView: View {
    @State private var isStartPressed = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                VStack(spacing: 30) {
                    Image("icon")
                        .resizable()
                        .frame(width: 130, height: 130)
                    
                    VStack(spacing: 20) {
                        Text("歡迎來到美食世界盃！")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Text("專屬你的美食盛典\n憑直覺選出更喜歡的食物\n就能找到心中的冠軍美食")
                            .font(.body)
                            .multilineTextAlignment(.center)
                        Text("準備好了嗎？\n現在馬上開始吧！")
                            .font(.body)
                            .multilineTextAlignment(.center)
                    }
                    
                    Button(action: {
                        isStartPressed = true
                    }) {
                        Text("START")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.black)
                            .cornerRadius(25)
                    }
                    
                }
                .padding(60)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(30)
                
                Spacer()
            }
            .padding()
            .navigationTitle("美食世界盃")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("美食世界盃")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    DismissButton()
                }
            }
            .navigationDestination(isPresented: $isStartPressed) {
                TwoChoicesView()
            }
        }
    }
}

#Preview {
    FoodWorldCupView()
}
