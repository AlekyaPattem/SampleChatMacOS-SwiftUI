//
//  ContentView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 01/08/24.
//

import SwiftUI

struct MainView: View {
    
    var firebaseRef = Firebase()
    @State var usersList = [UsersData]()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Main")) {
                    NavigationLink(destination: UsersListView(usersList: $usersList)) {
                        Label("Users", systemImage: "house")
                    }
                    NavigationLink(destination: UsersListView(usersList: $usersList)) {
                        Label("CHATS", systemImage: "person.crop.circle")
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200,maxWidth: 300)
            .onAppear(perform: {
                getUsers()
            })
            UsersListView(usersList: $usersList)
        }
    }
    
    func getUsers(){
        firebaseRef.getAllUsers { result in
            usersList = firebaseRef.userList
        }
    }
}

#Preview {
    MainView()
}
