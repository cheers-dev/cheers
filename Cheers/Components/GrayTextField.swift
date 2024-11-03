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
                textFieldStyle(TextField(label, text: text))

            case .password:
                textFieldStyle(SecureField(label, text: text))
        }
    }

    enum FieldType {
        case text, password
    }

    private func textFieldStyle<T: View>(_ view: T) -> some View {
        view.padding(12)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .textInputAutocapitalization(.never)
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var text = ""
    return GrayTextField("test", text: $text)
}
