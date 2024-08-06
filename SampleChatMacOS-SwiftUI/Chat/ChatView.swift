//
//  ChatView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 06/08/24.
//

import SwiftUI

struct ChatView: View {
    
    var firebaseRef              = Firebase()
    @State var message           = ""
    @Binding var recieverData    : UsersData?
    
    var body: some View {
        GeometryReader{ geo in
            VStack {
                Spacer()
                HStack{
                    TextField("Enter Message", text: $message)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                        .padding(.leading,10)
                        .padding(.trailing,10)
                        .padding(.vertical, 10)
                        .textFieldStyle(PlainTextFieldStyle())
                    Button("Send") {
                        addMessage()
                    }
                    .padding(.trailing,10)
                }
            }
        }
    }
    
    func addMessage(){
        var messageData = MessageData()
        messageData.message = message
        messageData.recieverId = recieverData!.userId
        messageData.senderId = UserDefaults.standard.string(forKey: "userData")!
        firebaseRef.addMessage(messageData: messageData, completion: { result in
            
        })
    }
    
}

//#Preview {
//    ChatView(, recieverData: <#Binding<UsersData?>#>)
//}

