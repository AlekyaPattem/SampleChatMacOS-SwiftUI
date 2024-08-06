//
//  LoginView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 01/08/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username              = ""
    @State private var password              = ""
    @State private var rememberMe            = false
    @State private var showRegistrationView  : Bool = false
    @State private var showToast             = false
    @State var toastMsg                      : String = ""
    @State private var showHomeView          : Bool = false
    var firebaseRef                          = Firebase()
    
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
                        Text("Login")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        TextField("Email ID", text: $username)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(30)
                            .padding(.horizontal, 40)
                            .textFieldStyle(PlainTextFieldStyle())
                        Button(action: {
                            validation()
                        }) {
                            Text("Login")
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
                            showRegistrationView = true
                        }) {
                            Text("Don't have an account? Register")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .navigationDestination(isPresented: $showRegistrationView) {
                            SignupView()
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
            .navigationBarBackButtonHidden()
        }
    }
    
    func validation(){
        if(username == ""){
            toastMsg = "Please enter username"
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
            firebaseRef.getUser(userId: username) { result in
                if result{
                    showHomeView = true
                }else{
                    toastMsg = "User doesn't exist"
                    withAnimation {
                        showToast = true
                    }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                if showToast{
                    showToast = false
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

