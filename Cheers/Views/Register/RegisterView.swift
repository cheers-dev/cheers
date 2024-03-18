//
//  RegisterView.swift
//  Cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct RegisterView: View {
    @State var mail: String = ""
    @State var name: String = ""
    @State var nickname: String = ""
    @State var password: String = ""
    @State var birth: Date = Date()
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Image("icon")
                    .resizable()
                    .frame(width: 120, height: 120)
                Text("註冊即可與朋友享受推薦系統")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            VStack(spacing: 20) {
                GrayTextField("信箱", text: $mail)
                GrayTextField("全名", text: $name)
                GrayTextField("用戶名稱", text: $nickname)
                GrayTextField("密碼", text: $password)
                GrayTextField("密碼", text: $password)
                DatePicker(
                    "生日",
                    selection: $birth,
                    displayedComponents: .date
                )
                .padding(.leading, 12)
                .foregroundStyle(.gray)
                Button(action: {}) {
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
        .font(.system(size: 14))
        .padding()
    }
}

#Preview {
    RegisterView()
}
