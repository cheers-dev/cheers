//
//  DismissButton.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss
    var iconColor: Color = .gray
    
    var body: some View {
        Button(action: {dismiss()}) {
            Image(systemName: "chevron.backward")
                .foregroundStyle(iconColor)
        }
    }
}

#Preview {
    DismissButton()
}
