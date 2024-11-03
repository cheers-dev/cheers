//
//  CreateChatroomView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import PhotosUI
import SwiftUI

// MARK: - CreateChatroomView

struct CreateChatroomView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: CreateChatroomVM
    
    @State var showAddMemberSheet = false
    @State var showErrorAlert = false
    
    @State var selectedImage: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    
    var body: some View {
        VStack {
            header
            chatroomInfo
            memberList
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showAddMemberSheet) {
            NavigationStack {
                CreateChatroomAddUserSheetView(
                    members: $vm.state.members,
                    friends: vm.state.friends.filter { friend in
                        !vm.state.members.contains { $0.id == friend.id }
                    }
                )
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .onReceive(vm.$error) { error in
            if error != nil { showErrorAlert.toggle() }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button(action: { showErrorAlert.toggle() }) { Text("OK") }
        } message: {
            if vm.error != nil { Text(String(describing: vm.error!)) }
        }
    }
    
    var header: some View {
        HStack {
            DismissButton()
            Text("建立聊天室")
            Spacer()
            Button(action: { Task {
                let res = await vm.createChatroom()
                if res { dismiss() }
            }}) {
                Text("建立").foregroundStyle(.black)
            }
        }
        .padding()
        .fontWeight(.medium)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .top)
    }
    
    var chatroomInfo: some View {
        HStack(spacing: 20) {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let data = selectedImageData,
                       let uiImage = UIImage(data: data)
                    {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .scaledToFill()
                    } else {
                        Image("icon").resizable()
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
            
            TextField("為聊天室命名...", text: $vm.state.name)
                .font(.footnote)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
    
    var memberList: some View {
        VStack(spacing: 12) {
            Divider()
            
            VStack(alignment: .leading) {
                Text("成員: ").font(.footnote)
                List {
                    Button(action: { showAddMemberSheet = true }) {
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
                    }
                    
                    ForEach(vm.state.members) { member in
                        HStack(spacing: 12) {
                            AsyncImageWithDefaultImage(imageURL: member.avatar)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            
                            Text(member.name)
                        }.swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(
                                role: .destructive,
                                action: { vm.state.members.removeAll { $0.id == member.id } }
                            ) { Image(systemName: "trash") }
                        }
                    }
                }.listStyle(.plain)
            }.frame(maxWidth: .infinity)
        }.padding(.horizontal)
    }
}

#Preview {
    CreateChatroomView(vm: CreateChatroomVM())
}
