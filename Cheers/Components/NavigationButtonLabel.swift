//
//  NavigationButtonLabel.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct NavigationButtonLabel: View {
    let systemName: String
    let label: String
    
    var body: some View {
            HStack {
                Image(systemName: systemName)
                Text(label)
                Spacer()
                Image(systemName: "chevron.forward")
        }

    }
}

#Preview {
    NavigationButtonLabel(
        systemName: "person.fill",
        label: "test"
    )
}
