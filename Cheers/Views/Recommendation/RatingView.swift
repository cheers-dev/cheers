//
//  RatingView.swift
//  cheers
//
//  Created by Tintin on 2024/9/9.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    let totalStars = 5
    
    var body: some View {
        HStack(spacing: 3){
            ForEach(1...totalStars, id: \.self){ index in
                if Double(index) <= rating {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else if Double(index) - 1 < rating {
                    Image(systemName: "star.leadinghalf.filled")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: 3.4)
}
