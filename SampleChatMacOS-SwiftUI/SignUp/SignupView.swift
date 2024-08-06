//
//  SignupView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 02/08/24.
//

import SwiftUI

struct SignupView: View {
    
    @State private var username         = ""
    @State private var mobile           = ""
    @State private var password         = ""
    @State private var showToast        = false
    @State private var showLoginView    : Bool = false
    @State private var showHomeView     : Bool = false
    @State var toastMsg : String        = ""
    var firebaseRef                     = Firebase()
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        Text("Signup")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        TextField("Username", text: $username)
                            .padding()
                        //                        .background(Color.clear)
                        //                        .foregroundColor(.white)
                        //                        .border(.white)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        TextField("Phone Number", text: $mobile)
                            .padding()
                        //                        .background(Color.clear)
                        //                        .foregroundColor(.white)
                        //                        .border(.white)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        SecureField("Password", text: $password)
                            .padding()
                        //                        .background(Color.clear)
                        //                        .foregroundColor(.white)
                        //                        .border(.white)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        //                    HStack {
                        //                        Toggle("Remember me", isOn: $rememberMe)
                        //                            .foregroundColor(.white)
                        //
                        //                        Spacer()
                        //
                        //                        Button(action: {
                        //                            // Forgot password action
                        //                        }) {
                        //                            Text("Forgot Password?")
                        //                                .foregroundColor(.white)
                        //                        }
                        //                    }
                        //                    .padding(.horizontal, 40)
                        
                        Button(action: {
                            validation()
                        }) {
                            Text("SignUp")
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(30)
                        }
                        .padding(.horizontal, 40)
                        .buttonStyle(PlainButtonStyle())
                        .navigationDestination(isPresented: $showHomeView) {
                            MainView()
                        }
                        
                        Button(action: {
                            showLoginView = true
                        }) {
                            Text("Do you have an account? Login")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .navigationDestination(isPresented: $showLoginView) {
                            LoginView()
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .frame(width: 500,height: 500)
                if showToast {
                    VStack {
                        Spacer()
                        ToastView(message: "\(toastMsg)")
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .zIndex(1)
                            .padding(.bottom, 30)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        
    }
    
    func validation(){
        if(username == ""){
            toastMsg = "Please enter username"
            withAnimation {
                showToast = true
            }
            
        }else if(mobile == ""){
            toastMsg = "Please enter phone number"
            withAnimation {
                showToast = true
            }
        }else if(password == ""){
            toastMsg = "Please enter password"
            withAnimation {
                showToast = true
            }
        }
        else{
            signup()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                if showToast{
                    showToast = false
                }
            }
        }
    }
    
    func signup(){
        let newUserRef = firebaseRef.db.collection(endPoints.users).document()
        let userId = newUserRef.documentID
        let userData: [String: Any] = [
            "userId"    : userId,
            "userName"  : username,
            "mobile"    : mobile,
            "password"  : password
        ]
        newUserRef.setData(userData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added with ID: \(userId)")
                showHomeView = true
            }
        }
    }
}

#Preview {
    SignupView()
}
