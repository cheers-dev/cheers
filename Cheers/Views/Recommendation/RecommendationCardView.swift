//
//  RecommendationCardView.swift
//  cheers
//
//  Created by Tintin on 2024/9/9.
//

import SwiftUI

struct RecommendationCardView: View {
    let name: String
    let category: String
    let rating: Double
    let address: String
    let phone: String
    let price: String
    
    @State private var isLiked: Bool = false
    @State private var isDisliked: Bool = false
    
    let fakedata: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 10){
                Text(name)
//                    .font(.system(size: 30))
                    .font(.title2)
                
                Text(category)
                    .font(.subheadline)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .foregroundColor(.gray)
                    .background(Color(red: 217/225.0, green: 217/225.0, blue: 217/225.0))
                    .clipShape(Capsule())
            }
            
            HStack(alignment: .center) {
                RatingView(rating: rating)
                Text(String(format: "%.1f", rating))
                    .bold()
                    .font(.system(size: 22))
                    .foregroundColor(.orange)
            }
            
            Text(address)
            
            HStack{
                Image(systemName: "phone.fill")
                Text(phone)
                Text("/")
                Image(systemName: "dollarsign")
                Text(price)
            }
            HStack{
                Button(action: {
                    if isDisliked {
                        isDisliked = false
                    }
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(isLiked ? .yellow : .black)
                }
                .padding(.trailing, 5)
                Text(isLiked ? "\(fakedata + 1)" : "\(fakedata)")
                    .padding(.trailing, 20)
                Button(action: {
//                    if isLiked {
//                        isLiked = false
//                    }
//                    isDisliked.toggle()
                }) {
                    Image(systemName: isDisliked ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                        .foregroundColor(isDisliked ? .gray : .black)
                }
                .padding(.trailing, 5)
                Text(isDisliked ? "\(fakedata + 1)" : "\(fakedata)")
            }
        }
    }
}

#Preview {
    RecommendationCardView(
        name: "阿里郎",
        category: "韓國餐廳",
        rating: 4.6,
        address: "台北市文山區指南路二段",
        phone: "02 1234 5678",
        price: "400-600"
    )
}
