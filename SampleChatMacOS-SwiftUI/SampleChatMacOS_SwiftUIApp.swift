//
//  SampleChatMacOS_SwiftUIApp.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 01/08/24.
//

import SwiftUI
import AppKit
import FirebaseCore
import FirebaseFirestore

@main
struct SampleChatMacOS_SwiftUIApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "isLogin"){
                MainView()
            }else{
                LoginView()
                    .frame(minWidth: 700,minHeight: 600)
            }
        }
    }
}

