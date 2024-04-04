//
//  GrayTextField.swift
//  Cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct GrayTextField: View {
    let type: FieldType
    let label: String
    var text: Binding<String>
    
    init(_ label: String, text: Binding<String>) {
        self.label = label
        self.text = text
        self.type = .text
    }
    
    init(_ label: String, type: FieldType, text: Binding<String>) {
        self.label = label
        self.type = type
        self.text = text
    }
    
    var body: some View {
        switch type {
            case .text:
                TextField(label, text: text)
                    .padding(12)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .textInputAutocapitalization(.never)
            case .password:
                SecureField(label, text: text)
                    .padding(12)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .textInputAutocapitalization(.never)
        }
    }
    
    enum FieldType {
        case text, password
    }
}

#Preview {
    @State var text = ""
    return GrayTextField("test", text: $text)
}
