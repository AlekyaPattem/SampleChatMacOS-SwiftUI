//
//  ContentView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 01/08/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader{geo in
            NavigationView {
                List {
                    Section(header: Text("Main")) {
                        NavigationLink(destination: UsersListView()) {
                            Label("Users", systemImage: "house")
                        }
                        NavigationLink(destination: UsersListView()) {
                            Label("CHATS", systemImage: "person.crop.circle")
                        }
                    }
                }
                .listStyle(SidebarListStyle())
//                .frame(minWidth: 200,maxWidth: 300)
                UsersListView()
            }
        }
    }
}

#Preview {
    MainView()
}
