//
//  StudentsModel.swift
//  StudentFirebaseSample
//
//  Created by KSMACMINI-017 on 19/06/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

public class studentsData {
    var firstName   : String = ""
    var lastName    : String = ""
    var classId     : String = ""
    var className   : String = ""
    var phoneNumber : String = ""
    var email       : String = ""
    var password    : String = ""
    var studentId   : String = ""
    var isSelected  : Bool   = false

    public func toMap(map:studentsData) ->[String:Any] {
        var mapData                 = [String:Any]()
        mapData["firstName"]        = map.firstName
        mapData["lastName"]         = map.lastName
        mapData["classId"]          = map.classId
        mapData["className"]        = map.className
        mapData["phoneNumber"]      = map.phoneNumber
        mapData["email"]            = map.email
        mapData["password"]         = map.password
        mapData["studentId"]        = map.studentId
        return mapData
    }

    public func toObjects(map:[String:Any]) -> studentsData {
        var mapData                 = studentsData()
        mapData.firstName           = map["firstName"] as? String ?? ""
        mapData.lastName            = map["lastName"] as? String ?? ""
        mapData.classId             = map["classId"] as? String ?? ""
        mapData.className           = map["className"] as? String ?? ""
        mapData.phoneNumber         = map["phoneNumber"] as? String ?? ""
        mapData.email               = map["email"] as? String ?? ""
        mapData.password            = map["password"] as? String ?? ""
        mapData.studentId           = map["studentId"] as? String ?? ""
        return mapData
    }
}

public class ClassesData {
    var className   : String = ""
    var classId     : String = ""

    public func toMap(map:ClassesData) ->[String:Any] {
        var mapData                 = [String:Any]()
        mapData["className"]        = map.className
        mapData["classId"]          = map.classId
        return mapData
    }

    public func toObjects(map:[String:Any]) -> ClassesData {
        var mapData                 = ClassesData()
        mapData.className           = map["className"] as? String ?? ""
        mapData.classId             = map["classId"] as? String ?? ""
        return mapData
    }
}

public class CommentsData{
    var commentID       : String = ""
    var postId          : String = ""
    var replyId         : String = ""
    var text            : String = ""
    var timestamp       = Timestamp(date: Date())
    var isComment       : Bool = false
    var replyCount      = 0

    public func toMap(map:CommentsData) ->[String:Any] {
        var mapData                 = [String:Any]()
        mapData["commentID"]        = map.commentID
        mapData["text"]             = map.text
        mapData["timestamp"]        = map.timestamp
        mapData["isComment"]        = map.isComment
        mapData["postId"]           = map.postId
        mapData["replyId"]          = map.replyId
        mapData["replyCount"]     = map.replyCount
        return mapData
    }

    public func toObjects(map:[String:Any]) -> CommentsData {
        var mapData                 = CommentsData()
        var formatedDate = Timestamp(date: Date())
        if map["timestamp"] is Timestamp {
            formatedDate        = map["timestamp"] as! Timestamp
        }else if map["timestamp"] is Date {
            formatedDate        = Timestamp(date:map["timestamp"] as! Date)
        }
        mapData.commentID           = map["commentID"] as? String ?? ""
        mapData.text                = map["text"] as? String ?? ""
        mapData.isComment           = map["isComment"] as? Bool ?? false
        mapData.postId              = map["postId"] as? String ?? ""
        mapData.replyId             = map["replyId"] as? String ?? ""
        mapData.replyCount          = map["replyCount"] as? Int ?? 0
        mapData.timestamp           = formatedDate
        return mapData
    }
}

public class PostData {
    var imageName       : String = ""
    var imageUrl        : String = ""
    var caption         : String = ""
    var postId          : String = ""
    var likeStatus      : Bool = true
    var createdAt       = Timestamp(date: Date())
    var commentsCount   = 0
    var comments        : [CommentsData]?

    public func toMap(map:PostData) ->[String:Any] {
        var mapData                 = [String:Any]()
        mapData["imageName"]        = map.imageName
        mapData["imageUrl"]         = map.imageUrl
        mapData["caption"]          = map.caption
        mapData["postId"]           = map.postId
        mapData["likeStatus"]       = map.likeStatus
        mapData["createdAt"]        = map.createdAt
        mapData["comments"]         = map.comments
        mapData["commentsCount"]    = map.commentsCount
        return mapData
    }

    public func toObjects(map:[String:Any]) -> PostData {
        var mapData                 = PostData()
        var formatedDate = Timestamp(date: Date())
        if map["createdAt"] is Timestamp {
            formatedDate        = map["createdAt"] as! Timestamp
        }else if map["createdAt"] is Date {
            formatedDate        = Timestamp(date:map["createdAt"] as! Date)
        }
        mapData.createdAt           = formatedDate
        mapData.imageName           = map["imageName"] as? String ?? ""
        mapData.imageUrl            = map["imageUrl"] as? String ?? ""
        mapData.caption             = map["caption"] as? String ?? ""
        mapData.postId              = map["postId"] as? String ?? ""
        mapData.likeStatus          = map["likeStatus"] as? Bool ?? true
        mapData.comments            = map["comments"] as? [CommentsData] ?? []
        mapData.commentsCount       = map["commentsCount"] as? Int ?? 0
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
}

class Firebase{
    static let sharedInstance = Firebase()

    var db                              = Firestore.firestore()
    var studentsList                    = [studentsData]()
    var selectedDocIds                  = [String]()
    var classesList                     = [ClassesData]()
    var maxNumber                       = 0
    var postMaxNo                       = 0
    var postsList                       = [PostData]()

    var lastCommentDocRef               : DocumentSnapshot?
    var commentListenerQuery            : ListenerRegistration?
    var newComments                     = [CommentsData]()

    var replyConversationListenerQuery  : ListenerRegistration?
    var lastReplyConversationDocRef     = [DocumentSnapshot]()
    var lastReplyDocRef                 : DocumentSnapshot?
    var lastReplyConversationId         = [String]()
    var newReplies                      = [CommentsData]()


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

    func getStudents(classId:String,completion:@escaping (Bool) -> ()){
        db.collection(endPoints.students)
            .whereField("classId", isEqualTo: classId)
            .addSnapshotListener { [self] documentSnapshot, err in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(err!)")
                    return
                }
                if let err = err {
                    print(err)
                    completion(false)
                } else {
                    studentsList.removeAll()
                    for docs in document.documents {
                        print("\(docs.documentID) => \(docs.data())")
                        studentsList.append(studentsData().toObjects(map: docs.data()))
                    }
                    if document.documents.count == 0
                    {
                        studentsList.removeAll()
                        completion(true)
                        return
                    }
                    completion(true)
                }
            }
    }

    func deleteStudent(doc:String,completion:@escaping (Bool) -> ()){
        db.collection(endPoints.students).document(doc).delete()
        completion(true)
        print("Document successfully removed!")
    }

    func deleteStudentInClass(doc:String,completion:@escaping (Bool) -> ()){
        db.collection(endPoints.students).document(doc).updateData([
            "classId"   : "",
            "className" : ""
        ])
        completion(true)
    }

    func addStudentsToClass(classData:ClassesData,completion:@escaping (Bool) -> ()){
        selectedDocIds.removeAll()
        for id in studentsList.indices{
            if studentsList[id].isSelected == true{
                selectedDocIds.append(studentsList[id].studentId)
            }else{
            }
        }
        for id in selectedDocIds{
            Task{
                do {
                    try await db.collection(endPoints.students).document(id).updateData([
                        "classId"   : classData.classId,
                        "className" : classData.className
                    ])
                    print("Document successfully updated")
                    completion(true)
                } catch {
                    print("Error updating document: \(error)")
                    completion(false)
                }
            }
        }
    }

    func getClasses(completion:@escaping (Bool) -> ()){
        db.collection(endPoints.classes)
            .addSnapshotListener { [self] (querySnapshot, err) in
                if let err = err {
                    print(err)
                    completion(false)
                } else {
                    classesList.removeAll()
                    for docs in querySnapshot!.documents {
                        print("\(docs.documentID) => \(docs.data())")
                        classesList.append(ClassesData().toObjects(map: docs.data()))
                        let documentName = docs.documentID
                        if documentName.hasPrefix("C") {
                            let numberString = documentName.replacingOccurrences(of: "C_", with: "")
                            if let number = Int(numberString) {
                                maxNumber = max(maxNumber, number)
                            }
                        }
                    }
                    completion(true)
                    if querySnapshot!.documents.count == 0
                    {
                        classesList.removeAll()
                        completion(true)
                        return
                    }
                }
            }
    }

    func addPost(doc:String,data:[String:Any],completion:@escaping (Bool) -> ()){
        db.collection(endPoints.post).document(doc).setData(data)
        completion(true)
    }

    func getPosts(completion:@escaping (Bool) -> ()){
        db.collection(endPoints.post)
            .getDocuments { [self] (querySnapshot, err) in
                if let err = err {
                    print(err)
                    completion(false)
                } else {
                    postsList.removeAll()
                    for (index, docs) in querySnapshot!.documents.enumerated() {// for docs in querySnapshot!.documents {
                        print("\(docs.documentID) => \(docs.data())")
                        postsList.append(PostData().toObjects(map: docs.data()))
                        let documentName = docs.documentID
                        if documentName.hasPrefix("P") {
                            let numberString = documentName.replacingOccurrences(of: "P_", with: "")
                            if let number = Int(numberString) {
                                postMaxNo = max(postMaxNo, number)
                            }
                        }
                    }
                    completion(true)
                    if querySnapshot!.documents.count == 0
                    {
                        return
                    }
                }
            }
    }

    func getComments(postDocId:String,completion:@escaping (Bool) -> ()){
        if commentListenerQuery != nil {
            print("commentListenerQuery Added already")
            return
        }
        newComments.removeAll()
        newReplies.removeAll()
        commentListenerQuery = db.collection(endPoints.comments)
            .whereField("postId", isEqualTo: postDocId)
            .whereField("isComment", isEqualTo: true)
            .order(by: "timestamp", descending: true)
            .limit(to:10)
            .addSnapshotListener() { [self] (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else {
                    completion(false)
                    return
                }
                if self.lastCommentDocRef == nil {
                    if let err = err {
                        print(err)
                        completion(false)
                    } else {
                        for docs in querySnapshot!.documents {
                            print("\(docs.documentID) => \(docs.data())")
                            newComments.append(CommentsData().toObjects(map: docs.data()))
                        }
                        if let lastSnapshot = querySnapshot!.documents.last {
                            self.lastCommentDocRef = lastSnapshot
                        }
                        if querySnapshot!.documents.count == 0
                        {
                            completion(true)
                            return
                        }
                        completion(true)
                    }
                }else{
                    querySnapshot!.documentChanges.forEach { diff in
                        if (diff.type == .added) {
                            let d = diff.document.data()
                            print("Added conversation: \(d["text"])")
                            var messageInfo = CommentsData().toObjects(map:d)
                            let filterMessage = self.newComments.filter{$0.commentID == messageInfo.commentID }
                            if filterMessage.count > 0 {
                                let row = self.newComments.firstIndex(where: {$0.commentID == messageInfo.commentID })
                                if row != nil
                                {
                                    if row! < self.newComments.count
                                    {
                                        self.newComments[row!] = messageInfo
                                    }
                                }
                            }
                            else{
                                self.newComments.insert(messageInfo, at: 0)
                            }
                        }
                    }
                    completion(true)
                }
            }
    }

    func getMoreComments(postDocId:String,completion:@escaping (Bool) -> ()){
        if self.lastCommentDocRef == nil {
            completion(false)
            return
        }
        db.collection(endPoints.comments)
            .whereField("postId", isEqualTo: postDocId)
            .whereField("isComment", isEqualTo: true)
            .order(by: "timestamp", descending: true)
            .start(afterDocument: self.lastCommentDocRef!)
            .limit(to:5)
            .getDocuments() { [self] (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else {
                    completion(false)
                    return
                }
                if let err = err {
                    print("getMoreComments \(err)")
                    completion(false)
                } else {
                    for docs in querySnapshot!.documents {
                        print("\(docs.documentID) => \(docs.data())")
                        var commentInfo = CommentsData().toObjects(map:docs.data())
                        let commentExists = self.newComments.filter{$0.commentID == commentInfo.commentID }
                        if commentExists.count == 0 {
                            newComments.append(CommentsData().toObjects(map: docs.data()))
                        }
                    }
                    if querySnapshot!.documents.count == 0
                    {
                        completion(true)
                    }else{
                        if let lastSnapshot = querySnapshot!.documents.last  {
                            self.lastCommentDocRef = lastSnapshot
                        }
                    }
                    completion(true)
                }
            }
    }

    func getRepliesList(commentId:String, completion:@escaping (Bool) -> ()){
       db.collection(endPoints.comments)
            .whereField("commentID", isEqualTo: commentId)
            .whereField("isComment", isEqualTo: false)
            .order(by: "timestamp",descending: false)
            .limit(to: 5).getDocuments { [self] documentSnapshot, error in //includeMetadataChanges:true
                print(error)
                guard let documents = documentSnapshot?.documents else {
                    return
                }
                    for docs in documents {
                        print("replies List --> \(docs.documentID) => \(docs.data())")
                        let messageInfo = CommentsData().toObjects(map:docs.data())
                        self.newReplies.append(messageInfo)
                    }
                    if let lastSnapshot = documents.last {
                        print("added lastSnapShot")
                        lastReplyDocRef = lastSnapshot
                    }
                    completion(true)
            }
    }

    func getMoreRepliesList(commentId: String, completion:@escaping (Bool) -> ()){
        if self.lastReplyDocRef == nil {
            completion(false)
            return
        }
        db.collection(endPoints.comments)
            .whereField("commentID", isEqualTo: commentId)
            .whereField("isComment", isEqualTo: false)
            .order(by: "timestamp",descending: false)
            .start(afterDocument:lastReplyDocRef!)
            .limit(to: 5)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("error while trying to more replies")
                } else {
                    for docs in querySnapshot!.documents {
                        var messageInfo = CommentsData().toObjects(map:docs.data())
                        self.newReplies.append(messageInfo)
                        print("messageInfo \(messageInfo)")
                    }
                    if querySnapshot!.documents.count == 0
                    {
                        print("documents count is 0")
                        completion(true)
                    }
                    else{
                        if let lastSnapshot = querySnapshot!.documents.last  {
                            lastReplyDocRef = lastSnapshot
                        }
                        print("last snapShot")
                        completion(true)
                    }
                }
            }
    }

    func updateCommentsCountForPost(id:String) {
        var data = [String:Any]()
        data["commentsCount"] = FieldValue.increment(Int64(1))
        db.collection(endPoints.post).document(id).setData(data,merge: true) { err in
        }
    }

    func updateRepliesCountForComment(id:String) {
        var data = [String:Any]()
        data["replyCount"] = FieldValue.increment(Int64(1))
        db.collection(endPoints.comments).document(id).setData(data,merge: true) { err in
        }
    }
}























