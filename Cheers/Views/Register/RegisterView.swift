//
//  RegisterView.swift
//  Cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var register: RegisterVM
    @State var showErrorAlert = false

    var body: some View {
        VStack(spacing: 40) {
            VStack {
                Image("icon")
                    .resizable()
                    .frame(width: 120, height: 120)
                Text("註冊即可與朋友享受推薦系統")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            VStack(spacing: 12) {
                GrayTextField("信箱", text: $register.mail)
                GrayTextField("帳號", text: $register.account)
                GrayTextField("全名", text: $register.name)
                GrayTextField("密碼", type: .password, text: $register.password)
                GrayTextField("再次輸入密碼", type: .password, text: $register.confirmPassword)
                DatePicker(
                    "生日",
                    selection: $register.birth,
                    displayedComponents: .date
                )
                .padding(.leading, 12)
                .foregroundStyle(.gray)
                Button(action: { register.submit() }) {
                    Text("註冊")
                        .padding(12)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            HStack {
                Text("已經有帳號了？")
                    .foregroundStyle(.gray)
                Button(action: {}) {
                    Text("登入")
                        .foregroundStyle(.black)
                }
            }
        }
        .scrollDismissesKeyboard(.automatic)
        .font(.system(size: 14))
        .padding()
        .onReceive(register.$error){ error in
            if error != nil {
                showErrorAlert.toggle()
            }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button(action: { showErrorAlert.toggle() }) {
                Text("OK")
            }
        } message: {
            Text(register.error?.localizedDescription ?? "")
        }
    }
}

#Preview {
    RegisterView(register: RegisterVM())
}
