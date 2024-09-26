//
//  TwoChoicesView.swift
//  cheers
//
//  Created by 楊晏禎 on 2024/9/12.
//

import SwiftUI

struct TwoChoicesView: View {
    @State private var foods = ["中式", "甜點", "日式", "美式", "越式", "義式", "韓式", "港式", "泰式", "法式", "西式", "東南亞", "異國料理", "酒吧"]
    @State private var rankings: [String] = []
    @State private var currentFood: String = ""
    @State private var comparisonIndex: Int = 0
    @State private var showResult = false
    
    private let foodImages: [String: String] = [
        "中式": "chinese", "甜點": "dessert", "日式": "japanese", "美式": "american",
        "越式": "vietnamese", "義式": "italy", "韓式": "korean", "港式": "hong_kong",
        "泰式": "tailand", "法式": "frence", "西式": "western", "東南亞": "southeast_asia",
        "異國料理": "exotic", "酒吧": "bar"]

    var body: some View {
        VStack(spacing: 50) {
            if showResult {
                VStack(spacing: 30) {
                    Text("結果出爐！")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("以下是你的美食席次")
                        .font(.headline)
                        .foregroundColor(.gray)
                    HStack(alignment: .bottom, spacing: 10) {
                        VStack {
                            Image(foodImages[rankings[1]]!)
                                .resizable()
                                .frame(width: 80, height: 130)
                                .clipShape(Circle())
                            Text("2")
                                .font(.system(size: 30))
                                .bold()
                                .foregroundColor(.black)
                            Text(rankings[1])
                                .font(.headline)
                            Spacer()
                                .frame(height: 30)
                        }
                        .frame(width: 100, height: 200)
                        .background(Color.gray)
                        .cornerRadius(10)
                        
                        VStack {
                            Image(foodImages[rankings[0]]!)
                                .resizable()
                                .frame(width: 100, height: 150)
                                .clipShape(Circle())
                            Text("1")
                                .font(.system(size: 30))
                                .bold()
                                .foregroundColor(.black)
                            Text(rankings[0])
                                .font(.headline)
                        }
                        .frame(width: 120, height: 240)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        
                        VStack {
                            Image(foodImages[rankings[2]]!)
                                .resizable()
                                .frame(width: 80, height: 110)
                                .clipShape(Circle())
                            Text("3")
                                .font(.system(size: 30))
                                .bold()
                                .foregroundColor(.black)
                            Text(rankings[2])
                                .font(.headline)
                            Spacer()
                                .frame(height: 20)
                        }
                        .frame(width: 100, height: 180)
                        .background(Color.red)
                        .cornerRadius(10)
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
                
                if comparisonIndex < rankings.count && !currentFood.isEmpty {
                    HStack(spacing: 0) {
                        if let imageName = foodImages[rankings[comparisonIndex]] {
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 200, height: 230)
                                    .cornerRadius(5)
                                Button(action: {
                                    makeChoice(0)
                                }) {
                                    Text(rankings[comparisonIndex])
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 44)
                                        .background(Color.black)
                                        .cornerRadius(22)
                                }
                            }
                        }

                        if let imageName = foodImages[currentFood] {
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 200, height: 230)
                                    .cornerRadius(5)
                                Button(action: {
                                    makeChoice(1)
                                }) {
                                    Text(currentFood)
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
            startComparison()
        }
    }

    func startComparison() {
        if foods.count > 1 {
            rankings = [foods[0]]
            currentFood = foods[1]
            comparisonIndex = 0
        }
    }

    func makeChoice(_ preferredIndex: Int) {
        if preferredIndex == 0 {
            comparisonIndex += 1
            if comparisonIndex >= rankings.count {
                rankings.append(currentFood)
                if rankings.count < foods.count {
                    currentFood = foods[rankings.count]
                    comparisonIndex = 0
                }
            }
        } else {
            rankings.insert(currentFood, at: comparisonIndex)
            if rankings.count < foods.count {
                currentFood = foods[rankings.count]
                comparisonIndex = 0
            }
        }

        if rankings.count == foods.count {
            showResult = true
        }
    }
}

#Preview {
    TwoChoicesView()
}
