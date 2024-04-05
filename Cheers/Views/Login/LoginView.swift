//
//  LoginView.swift
//  Cheers
//
//  Created by Dong on 2024/3/18.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var login: LoginVM
    @State var showErrorAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            Image("icon")
                .resizable()
                .frame(width: 160, height: 160)
            Text("雀食 Cheers")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            VStack(spacing: 20) {
                GrayTextField("信箱", text: $login.account)
                GrayTextField("密碼", type: .password, text: $login.password)
                Button(action: { login.submit() }) {
                    Text("登入")
                        .padding(12)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Button(action: {}) {
                    Text("忘記密碼")
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
            HStack {
                Text("還沒有帳號嗎？")
                    .foregroundStyle(.gray)
                Button(action: { }) {
                    Text("註冊")
                        .foregroundStyle(.black)
                }
            }
        }
        .font(.system(size: 14))
        .padding()
        .onReceive(login.$error){ error in
            if error != nil {
                showErrorAlert.toggle()
            }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button(action: { showErrorAlert.toggle() }) {
                Text("OK")
            }
        } message: {
            Text(login.error?.localizedDescription ?? "")
        }
    }
}

#Preview {
    LoginView(login: LoginVM())
}
