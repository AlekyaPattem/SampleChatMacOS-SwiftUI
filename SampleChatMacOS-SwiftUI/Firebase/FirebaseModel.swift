//
//  StudentsModel.swift
//  StudentFirebaseSample
//
//  Created by KSMACMINI-017 on 19/06/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import SwiftUI

public class UsersData:Identifiable {
    var userId         : String = ""
    var userName       : String = ""
    var mobile         : String = ""
    var password       : String = ""

    public func toMap(map:UsersData) ->[String:Any] {
        var mapData                 = [String:Any]()
        mapData["userId"]           = map.userId
        mapData["userName"]         = map.userName
        mapData["mobile"]           = map.mobile
        mapData["password"]         = map.password
        return mapData
    }

    public func toObjects(map:[String:Any]) -> UsersData {
        var mapData                 = UsersData()
        var formatedDate = Timestamp(date: Date())
        if map["createdAt"] is Timestamp {
            formatedDate        = map["createdAt"] as! Timestamp
        }else if map["createdAt"] is Date {
            formatedDate        = Timestamp(date:map["createdAt"] as! Date)
        }
        mapData.userId              = map["userId"] as? String ?? ""
        mapData.userName            = map["userName"] as? String ?? ""
        mapData.mobile              = map["mobile"] as? String ?? ""
        mapData.password            = map["password"] as? String ?? ""
        return mapData
    }
}

public class MessageData{
    var messageID          : String = ""
    var senderId           : String = ""
    var recieverId         : String = ""
    var message            : String = ""
    var timestamp          = Timestamp(date: Date())

    public func toMap(map:MessageData) ->[String:Any] {
        var mapData                  = [String:Any]()
        mapData["messageID"]         = map.messageID
        mapData["senderId"]          = map.senderId
        mapData["recieverId"]        = map.recieverId
        mapData["message"]           = map.message
        mapData["timestamp"]         = map.timestamp
        return mapData
    }

    public func toObjects(map:[String:Any]) -> MessageData {
        var mapData                 = MessageData()
        var formatedDate = Timestamp(date: Date())
        if map["timestamp"] is Timestamp {
            formatedDate        = map["timestamp"] as! Timestamp
        }else if map["timestamp"] is Date {
            formatedDate        = Timestamp(date:map["timestamp"] as! Date)
        }
        mapData.messageID            = map["messageID"] as? String ?? ""
        mapData.senderId             = map["senderId"] as? String ?? ""
        mapData.recieverId           = map["recieverId"] as? String ?? ""
        mapData.message              = map["message"] as? String ?? ""
        mapData.timestamp            = formatedDate
        return mapData
    }
}

struct endPoints{
    static let students     = "Students"
    static let classes      = "Classes"
    static let post         = "Post"
    static let comments     = "Comments"
    static let reply        = "Reply"
    static let users        = "Users"
    static let conversation = "conversation"
}

class Firebase{
    static let sharedInstance = Firebase()

    var db                              = Firestore.firestore()

    var lastCommentDocRef               : DocumentSnapshot?
    var commentListenerQuery            : ListenerRegistration?

    var replyConversationListenerQuery  : ListenerRegistration?
    var lastReplyConversationDocRef     = [DocumentSnapshot]()
    var lastReplyDocRef                 : DocumentSnapshot?
    var lastReplyConversationId         = [String]()

    //Chat Users
    var userExists  = false
    var userList    = [UsersData]()
    var userData    = UsersData()
    
    func clearMessageListener()
    {
        self.lastCommentDocRef = nil
        if self.commentListenerQuery != nil {
            self.commentListenerQuery?.remove()
            self.commentListenerQuery = nil
        }
        self.lastReplyConversationId.removeAll()
        self.lastReplyConversationDocRef.removeAll()
        if self.replyConversationListenerQuery != nil {
            self.replyConversationListenerQuery?.remove()
            self.replyConversationListenerQuery = nil
        }
    }
    
    func getUser(userId:String,completion:@escaping (Bool) -> ()){
        db.collection(endPoints.users)
            .whereField("userName", isEqualTo: userId)
            .addSnapshotListener { [self] documentSnapshot, err in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(err!)")
                    return
                }
                if let err = err {
                    print(err)
                    completion(false)
                } else {
                    userExists = false
                    for docs in document.documents {
                        print("\(docs.documentID) => \(docs.data())")
                        userData = UsersData().toObjects(map: docs.data())
                        UserDefaults.standard.setValue(userData.userId, forKey: "userData")
                        userExists = true
                    }
                    if document.documents.count == 0
                    {
                        userExists = false
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
    }
    
    func getAllUsers(completion:@escaping (Bool) -> ()){
        db.collection(endPoints.users)
            .getDocuments { [self] (querySnapshot, err) in
                if let err = err {
                    print(err)
                    completion(false)
                } else {
                    userList.removeAll()
                    for docs in querySnapshot!.documents {//for (index, docs) in querySnapshot!.documents.enumerated() {
                        print("\(docs.documentID) => \(docs.data())")
                        userList.append(UsersData().toObjects(map: docs.data()))
                    }
                    completion(true)
                    if querySnapshot!.documents.count == 0
                    {
                        return
                    }
                }
            }
    }
    
    func addMessage(messageData: MessageData,completion:@escaping (Bool) -> ()){
        let messageRef = db.collection(endPoints.conversation).document()
        let messageId = messageRef.documentID
        messageData.messageID = messageId
        let userData = messageData.toMap(map: messageData)
        messageRef.setData(userData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added with ID: \(messageId)")
            }
        }
    }
}

struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}





















