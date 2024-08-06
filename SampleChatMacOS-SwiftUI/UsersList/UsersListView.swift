//
//  UsersListView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 01/08/24.
//

import SwiftUI

struct UsersListView: View {
    
    @Binding var usersList        : [UsersData]
    @State var isChatView = false
    
    var body: some View {
        NavigationView{
            List() {
                ForEach(usersList) { element in
                    NavigationLink(destination: ChatView(recieverData: .constant(element))) {
                        HStack{
                            Text("\(element.userName)")
                        }
                    }
//                    HStack{
//                        Text("\(element.userName)")
//                    }
//                    .navigationDestination(isPresented: $isChatView) {
//                        ChatView()
//                    }
//                    .onTapGesture {
//                        print("selected item is \(element.userName)")
//                        isChatView = true
//                    }
                }
            }
        }
    }
}

#Preview {
    UsersListView(usersList: .constant(Firebase().userList))
}
