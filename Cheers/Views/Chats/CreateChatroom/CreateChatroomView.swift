//
//  CreateChatroomView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import PhotosUI
import SwiftUI

struct CreateChatroomView: View {
    @State var name = ""
    @State var intention: Intention = .dailyEating
    
    @State var selectedImage: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    
    var body: some View {
        VStack {
            HStack {
                DismissButton()
                Text("建立聊天室")
                Spacer()
                Button(action: {}) {
                    Text("Create")
                        .foregroundStyle(.black)
                }
            }
            .padding()
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6) ,ignoresSafeAreaEdges: .top)
            
            HStack(spacing: 20) {
                ZStack(alignment: .bottomTrailing) {
                    Group {
                        if let data = selectedImageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .scaledToFill()
                        } else {
                            Image("icon")
                                .resizable()
                        }
                    }
                    .padding(4)
                    .frame(width: 50, height: 50)
                    .background(Color(UIColor.systemGray5))
                    .clipShape(Circle())
                    
                    PhotosPicker("+", selection: $selectedImage)
                        .foregroundStyle(.black)
                        .frame(width: 20, height: 20)
                        .background(Color(UIColor.systemGray6))
                        .clipShape(Circle())
                }
                
                TextField("為聊天室命名...", text: $name)
                    .font(.footnote)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            .padding(.horizontal, 40)
            
            VStack(spacing: 12) {
                Divider()
                
                HStack {
                    Text("聚會目的")
                        .foregroundStyle(.gray)
                    Spacer()
                    Picker("聚會目的", selection: $intention) {
                        ForEach(Intention.allCases) { intent in
                            Text(intent.rawValue).tag(intent)
                        }
                    }
                    .tint(.black)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("成員: ")
                        .font(.footnote)
                        .padding(.horizontal)
                    List {
                        HStack(spacing: 12) {
                            Circle()
                                .stroke(Color(UIColor.systemGray5), lineWidth: 1)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: "plus")
                                }
                            
                            Text("新增成員")
                            Spacer()
                        }
                        
                        HStack(spacing: 12) {
                            AsyncImageWithDefaultImage(imageURL: URL(string: ""))
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            
                            Text("User name")
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive, action: {}) {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()

            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
    
    enum Intention: String, CaseIterable, Identifiable {
        case dailyEating = "日常吃吃",
             friendsDining = "朋友聚餐",
             coupleDating = "情侶約會",
             familyDining = "家庭聚餐",
             birth = "慶祝生日",
             holiday = "慶祝節日",
             business = "商務用途",
             treating = "會客宴請",
             mentorDining = "謝師宴/導生聚"
        
        var id: Self { self }
    }
}

#Preview {
    CreateChatroomView()
}
