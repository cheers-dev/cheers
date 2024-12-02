//
//  RecommendationCardView.swift
//  cheers
//
//  Created by Tintin on 2024/9/9.
//

import SwiftUI

struct RecommendationCardView: View {
    @ObservedObject var chatroomVM: ChatroomVM
    @Binding var recommendation: RecommendationCard
    let userId: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 10){
                Text(recommendation.name)
//                    .font(.system(size: 30))
                    .font(.title2)
                
                Text(recommendation.category)
                    .font(.subheadline)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .foregroundColor(.gray)
                    .background(Color(red: 217/225.0, green: 217/225.0, blue: 217/225.0))
                    .clipShape(Capsule())
            }
            
            HStack(alignment: .center) {
                RatingView(rating: recommendation.rating)
                Text(String(format: "%.1f", recommendation.rating))
                    .bold()
                    .font(.system(size: 22))
                    .foregroundColor(.orange)
            }
            
            Text(recommendation.address)
            
            HStack{
                Image(systemName: "phone.fill")
                Text(recommendation.phone)
                Text("/")
                Image(systemName: "dollarsign")
                Text(recommendation.price)
            }
            HStack{
                likeButton
                Text("\(recommendation.likes ?? 0)")
                    .padding(.trailing, 20)
//                dislikeButton
//                Text("\(recommendation.dislikes ?? 0)")
            }
        }
        .onAppear{
            // initialize isLiked & isDisliked
            updateLikeDislikeStatus()
        }
    }
    
    private var likeButton: some View {
        Button(action: {
//            recommendation.isDisliked = recommendation.isDisliked ?? false
            
            if recommendation.isLiked == true {
                // cancel like
                recommendation.isLiked = false
                recommendation.likes = max((recommendation.likes ?? 0) - 1, 0)
            } else {
                // cancel dislike & like
//                if recommendation.isDisliked == true {
//                    recommendation.isDisliked = false
//                    recommendation.dislikes = max((recommendation.dislikes ?? 0) - 1, 0)
//                }

                recommendation.isLiked = true
                recommendation.likes = (recommendation.likes ?? 0) + 1
            }
            chatroomVM.changeLikeStatus(restaurant: recommendation.name, likeStatus: recommendation.isLiked ?? false)
        }) {
            Image(systemName: recommendation.isLiked == true ? "hand.thumbsup.fill" : "hand.thumbsup")
                .foregroundColor(recommendation.isLiked == true ? .yellow : .black)
        }
        .padding(.trailing, 5)
    }
    
    private var dislikeButton: some View {
        Button(action: {
            
        }) {
            Image(systemName: recommendation.isDisliked == true ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                .foregroundColor(recommendation.isDisliked == true ? .gray : .black)
        }
        .padding(.trailing, 5)
    }
    
    private func updateLikeDislikeStatus() {
        if let likeStatus = recommendation.like_status?.first(where: { $0.userId == userId }) {
            recommendation.isLiked = likeStatus.like
            recommendation.isDisliked = !likeStatus.like
        } else {
            recommendation.isLiked = false
            recommendation.isDisliked = false
        }
    }
}
