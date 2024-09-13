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
    @State var selectedUser: UsersData? = nil

    var body: some View {
        
        
        NavigationSplitView {
            // Side Menu (User List)
            List(usersList,selection: $selectedUser) { user in
                Text(user.userName)
            }
            .frame(minWidth: 200,maxWidth: 300)
                .onAppear(perform: {
                    getUsers()
                }) // Side menu width
            
        } detail: {
            
//            UsersListView(usersList: $usersList)
            // Chat View for selected user
            if selectedUser != nil {
                ChatView(recieverData: $selectedUser)
            } else {
                Text("Select a chat to start messaging.")
                    .foregroundColor(.gray)
            }
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




/*
 struct MainView: View {
     
     var firebaseRef = Firebase()
     @State var usersList = [UsersData]()
     @State var selectedUser: UsersData? = nil

     var body: some View {
         
         
         NavigationSplitView {
             // Side Menu (User List)
             List(usersList,selection: $selectedUser) { user in
                 Text(user.userName)
             }
             .frame(minWidth: 200,maxWidth: 300)
                 .onAppear(perform: {
                     getUsers()
                 }) // Side menu width
             
         } detail: {
             
 //            UsersListView(usersList: $usersList)
             // Chat View for selected user
             if selectedUser != nil {
                 ChatView(recieverData: $selectedUser)
 //                //                        UsersListView(usersList: $usersList)
 //                //                        ChatView(user: user, messages: messages)
             } else {
                 Text("Select a chat to start messaging.")
                     .foregroundColor(.gray)
             }
         }
         
         
         
         //        NavigationView {
         //            List {
         //                Section(header: Text("Main")) {
         //                    NavigationLink(destination: UsersListView(usersList: $usersList)) {
         //                        Label("Users", systemImage: "house")
         //                    }
         //                    NavigationLink(destination: UsersListView(usersList: $usersList)) {
         //                        Label("CHATS", systemImage: "person.crop.circle")
         //                    }
         //                }
         //            }
         //            .listStyle(SidebarListStyle())
         //            .frame(minWidth: 200,maxWidth: 300)
         //            .onAppear(perform: {
         //                getUsers()
         //            })
         //            UsersListView(usersList: $usersList)
         //        }
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
 */
