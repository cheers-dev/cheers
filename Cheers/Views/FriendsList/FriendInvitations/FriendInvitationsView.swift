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
            HStack {
                DismissButton()
                Text("好友申請")
                Spacer()
            }
            .padding()
            
            .fontWeight(.medium)
            .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .top)
            
            HStack {
                GrayTextField("輸入使用者 id", text: $searchId)
                    .font(.footnote)
                Button(action: { isScanSheetShow.toggle() }) {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title)
                        .foregroundStyle(.black)
                }
            }
            .padding()
            
            Spacer()
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
        .onReceive(friendInvitationVM.$error) { error in
            if error != nil {
                showErrorAlert.toggle()
            }
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
        .sheet(isPresented: $isScanSheetShow) {
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
        .presentationDetents([.medium])
    }
}

#Preview {
    FriendInvitationsView(friendInvitationVM: FriendInvitationsVM())
}
