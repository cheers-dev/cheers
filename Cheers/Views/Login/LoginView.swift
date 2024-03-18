//
//  LoginView.swift
//  Cheers
//
//  Created by Dong on 2024/3/18.
//

import SwiftUI

struct LoginView: View {
    @State var mail: String = ""
    @State var password: String = ""
    
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
                GrayTextField("信箱", text: $mail)
                GrayTextField("密碼", type: .password, text: $password)
                Button(action: {}) {
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
                Button(action: {}) {
                    Text("註冊")
                        .foregroundStyle(.black)
                }
            }
        }
        .font(.system(size: 14))
        .padding()
    }
}

#Preview {
    LoginView()
}
