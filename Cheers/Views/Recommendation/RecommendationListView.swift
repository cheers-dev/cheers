//
//  RecommendationListView.swift
//  cheers
//
//  Created by Tintin on 2024/9/9.
//

import SwiftUI

struct RecommendationListView: View {
    @Binding var recommendations: [RecommendationCard]
    
    var body: some View {
        VStack{
            header
            if recommendations.isEmpty {
                Spacer()
                ProgressView("Loading recommendations...")
                Spacer()
            } else {
                List(recommendations, id: \.name) { recommendation in
                    RecommendationCardView(
                        name: recommendation.name,
                        category: recommendation.category,
                        rating: recommendation.rating,
                        address: recommendation.address,
                        phone: recommendation.phone,
                        price: recommendation.price
                    )
                    .padding(.vertical, 15)
                    .padding(.horizontal, 5)
                    
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var header: some View {
        HStack {
            DismissButton()
            Text("推薦清單")
                .font(.title3)
            Spacer()
        }
        .padding()
        .fontWeight(.semibold)
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .top)
    }
}

//#Preview {
//    RecommendationListView(
//        recommendations: [
//            RecommendationCard(name: "阿里郎", category: "韓國餐廳", rating: 4.6, address: "台北市文山區指南路二段", phone: "02 1234 5678", price: "400-600"),
//            RecommendationCard(name: "牛排館", category: "美式餐廳", rating: 4.2, address: "台北市大安區復興南路", phone: "02 8765 4321", price: "800-1200"),
//        ]
//    )
//}
