//
//  TwoChoicesView.swift
//  cheers
//
//  Created by 楊晏禎 on 2024/9/12.
//

import SwiftUI

struct TwoChoicesView: View {
    @ObservedObject var viewModel = TwoChoicesVM()
    
    private let foodImages: [String: String] = [
        "中式": "chinese", "甜點": "dessert", "日式": "japanese", "美式": "american",
        "越式": "vietnamese", "義式": "italy", "韓式": "korean", "港式": "hong_kong",
        "泰式": "tailand", "法式": "frence", "西式": "western", "東南亞": "southeast_asia",
        "異國料理": "exotic", "酒吧": "bar"]

    var body: some View {
        VStack(spacing: 50) {
            if viewModel.showResult {
                VStack(spacing: 30) {
                    Text("結果出爐！")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("以下是你的美食席次")
                        .font(.headline)
                        .foregroundColor(.gray)
                    HStack(alignment: .bottom, spacing: 10) {
                        ForEach([1, 0, 2], id: \.self) { index in
                            VStack {
                                Image(foodImages[viewModel.rankings[index]]!)
                                    .resizable()
                                    .frame(width: 80 + CGFloat(20 * (2 - index)), height: 130 + CGFloat(20 * (2 - index)))
                                    .clipShape(Circle())
                                Text("\(index + 1)")
                                    .font(.system(size: 30))
                                    .bold()
                                    .foregroundColor(.black)
                                Text(viewModel.rankings[index])
                                    .font(.headline)
                                Spacer()
                                    .frame(height: CGFloat(30 - 10 * index))
                            }
                            .frame(width: 100 + CGFloat(20 * (2 - index)), height: 200 + CGFloat(20 * (2 - index)))
                            .background(index == 1 ? Color.yellow : (index == 2 ? Color.red : Color.gray))
                            .cornerRadius(10)
                        }
                    }
                }
            } else {
                HStack(spacing: 20) {
                    Image("icon")
                        .resizable()
                        .frame(width: 80, height: 80)
                
                    Text("請您憑直覺選出喜歡的食物！")
                        .font(.headline)
                        .padding(8)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(12)
                }
                
                if viewModel.comparisonIndex < viewModel.rankings.count && !viewModel.currentFood.isEmpty {
                    HStack(spacing: 0) {
                        if let imageName = foodImages[viewModel.rankings[viewModel.comparisonIndex]] {
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 200, height: 230)
                                    .cornerRadius(5)
                                Button(action: {
                                    viewModel.makeChoice(0)
                                }) {
                                    Text(viewModel.rankings[viewModel.comparisonIndex])
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 44)
                                        .background(Color.black)
                                        .cornerRadius(22)
                                }
                            }
                        }

                        if let imageName = foodImages[viewModel.currentFood] {
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 200, height: 230)
                                    .cornerRadius(5)
                                Button(action: {
                                    viewModel.makeChoice(1)
                                }) {
                                    Text(viewModel.currentFood)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 44)
                                        .background(Color.black)
                                        .cornerRadius(22)
                                }
                            }
                        }
                    }
                }
            }
        }
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
        .padding()
        .onAppear {
            viewModel.startComparison()
        }
    }
}

#Preview {
    TwoChoicesView()
}
