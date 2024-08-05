//
//  SignupView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 02/08/24.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var mobile = ""
    @State private var password = ""
    @State private var showToast = false
    @State private var showRegistrationView: Bool = false
    @State var toastMsg : String = ""
    var firebaseRef = Firebase()

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Login Form
                VStack(spacing: 20) {
                    Text("Signup")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    TextField("Email ID", text: $email)
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
                        signup()
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
                    
                    Button(action: {
                        // Register action
                    }) {
                        Text("Do you have an account? Login")
//                            .foregroundColor(.white)
                            
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .frame(width: 500,height: 500)
        }
    }
    
//    func validation(){
//        if(email == ""){
//                toastMsg = "Please enter email"
//                toastMsg = "Please enter password"
//            withAnimation {
//                showToast = true
//            }
//            
//        }else if(password == ""){
//            toastMsg = "Please enter password"
//        }
//        else{
//            showRegistrationView = true
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            withAnimation {
//                if showToast{
//                    showToast = false
//                }
//            }
//        }
//    }
    
    func signup(){
        do {
            let ref = firebaseRef.db.collection(endPoints.users).addDocument(data: [
                "email": $email,
                "mobile": $mobile,
                "password": $password,
            ])
            print("Document added with ID: \(ref.documentID)")
        } catch {
            print("Error adding document: \(error)")
        }
    }
}

#Preview {
    SignupView()
}
