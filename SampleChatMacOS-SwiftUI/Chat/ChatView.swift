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
    @State var messages          =  [MessageData]()
    
    var body: some View {
        GeometryReader{ geo in
            VStack {
//                Spacer()
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(messages) { message in
                            MessageBubbleView(message: message)
                                .frame(maxWidth: .infinity, alignment: message.senderId == UserDefaults.standard.string(forKey: "userData")! ? .trailing : .leading)
                        }
                    }
                    .padding()
                }
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
            .onAppear(perform: {
                getMessages()
            })
        }
    }
    
    func getMessages(){
        firebaseRef.getMessages(senderId: UserDefaults.standard.string(forKey: "userData")!, recieverId: recieverData!.userId) { result in
                messages = firebaseRef.messagesList
        }
    }
    
    func addMessage(){
        var messageData = MessageData()
        messageData.message = message
        messageData.recieverId = recieverData!.userId
        messageData.senderId = UserDefaults.standard.string(forKey: "userData")!
        firebaseRef.addMessage(messageData: messageData, completion: { result in
            message = ""
            getMessages()
        })
    }
    
}

struct MessageBubbleView: View {
    var message: MessageData
    
    var body: some View {
        Text(message.message)
            .padding()
            .background(message.senderId == UserDefaults.standard.string(forKey: "userData")! ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(message.senderId == UserDefaults.standard.string(forKey: "userData")! ? Color.white : Color.black)
            .cornerRadius(10)
    }
}

//#Preview {
//    ChatView(recieverData: )
//}

