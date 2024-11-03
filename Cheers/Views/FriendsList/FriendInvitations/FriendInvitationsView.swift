//
//  FriendInvitationsView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import CodeScanner
import SwiftUI

struct FriendInvitationsView: View {
    @ObservedObject var friendInvitationVM: FriendInvitationsVM
    @State var searchId = ""
    @State var isScanSheetShow = false
    @State var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            title
            userIdInputField
            invitationsList
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
        .onReceive(friendInvitationVM.$error) { error in
            if error != nil { showErrorAlert.toggle() }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button(action: { showErrorAlert.toggle() }) {
                Text("OK")
            }
        } message: {
            if friendInvitationVM.error != nil {
                Text(String(describing: friendInvitationVM.error!))
            }
        }
        .sheet(isPresented: $isScanSheetShow) { codeScanner }
        .presentationDetents([.medium])
    }
    
    var title: some View {
        HStack {
            DismissButton()
            Text("好友申請")
            Spacer()
        }
        .padding()
        .fontWeight(.medium)
        .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .top)
    }
    
    var userIdInputField: some View {
        HStack {
            ZStack(alignment: .trailing) {
                GrayTextField("輸入使用者 id", text: $searchId)
                    .font(.footnote)
                if searchId != "" {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .padding(.horizontal, 8)
                            .font(.title2)
                            .foregroundStyle(.black)
                    }
                }
            }
            Button(action: {}) {
                Image(systemName: "qrcode.viewfinder")
                    .font(.title)
                    .foregroundStyle(.black)
            }
        }
        .padding()
    }
    
    var invitationsList: some View {
        List($friendInvitationVM.friendInvitations) { $friendInvitation in
            HStack {
                UserAvatarWithName(user: $friendInvitation.requestor)
                Spacer()
                
                Button(action: { Task {
                    await friendInvitationVM
                        .acceptInvitation($friendInvitation.wrappedValue.id)
                }}) {
                    Text("接受")
                }.tint(.green)
                
                Button(action: { Task {
                    await friendInvitationVM
                        .rejectInvitation($friendInvitation.wrappedValue.id)
                }}) {
                    Text("拒絕")
                }.tint(.red)
            }
            .buttonStyle(.bordered)
        }.listStyle(.plain)
    }
    
    var codeScanner: some View {
        VStack {
            CodeScannerView(codeTypes: [.qr], simulatedData: "https://dongdong867.dev") { response in
                switch response {
                    case .success(let result):
                        print(result)
                    case .failure(let error):
                        print(error)
                }
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    FriendInvitationsView(friendInvitationVM: FriendInvitationsVM())
}
