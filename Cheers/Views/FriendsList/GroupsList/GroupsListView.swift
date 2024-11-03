//
//  GroupsListView.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

struct GroupsListView: View {
    @ObservedObject var vm: GroupsListVM
    
    @State var search = ""
    @State var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            List(vm.state.groups) { group in
                NavigationLink(destination: Text(group.name)) {
                    HStack(spacing: 12) {
                        AsyncImageWithDefaultImage(imageURL: group.avatar ?? URL(string: ""))
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text(group.name)
                            .fontWeight(.medium)
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $search)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                DismissButton()
            }

            ToolbarItem(placement: .principal) {
                Text("群組列表")
            }
        }
        .onReceive(vm.$error) { error in
            if error != nil { showErrorAlert.toggle() }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button(action: { showErrorAlert.toggle() }) { Text("OK") }
        } message: {
            if vm.error != nil { Text(String(describing: vm.error!)) }
        }

    }
}

#Preview {
    GroupsListView(vm: GroupsListVM())
}
