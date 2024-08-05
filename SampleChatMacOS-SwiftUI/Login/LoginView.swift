//
//  LoginView.swift
//  SampleChatMacOS-SwiftUI
//
//  Created by KSMACMINI-017 on 01/08/24.
//

//import SwiftUI
//
//struct LoginView: View {
//    @State var email    : String = ""
//    @State var password : String = ""
//    var body: some View {
//        GeometryReader{geo in
//            VStack{
//                Text("Login")
//                VStack{
//                    ViewThatFits{
//                        TextField("Email ID", text: $email)
//                            .textFieldStyle(PlainTextFieldStyle())
//                            .background(Color.clear)
//                    }
//                    .frame(width: 300,height: 30)
//                    .border(Color.white)
//                    .padding()
//                    .cornerRadius(30)
//                    HStack{
//                        TextField("Password", text: $password)
//                            .background(Color.clear)
//                            .textFieldStyle(PlainTextFieldStyle())
//                            
//                        Button("", systemImage: "lock.fill") {
//                            
//                        }
//                        .background(Color.clear)
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                    .frame(width: 300,height: 30)
//                    .background(Color.clear)
//                    .border(Color.white)
//                    .cornerRadius(30)
//                }
//                Button("Login") {
//                    print("login selected")
//                }
//                .frame(width: 300,height: 30)
//                .background(Color.white)
//                .buttonStyle(PlainButtonStyle())
//                .cornerRadius(30)
//                .padding()
//                
//            }
//            .border(Color.white)
////            .frame(width: 300, height: 200,alignment: .center)
//            .cornerRadius(10)
//            .frame(width: geo.size.width/2,height: geo.size.height).background(Color.blue)
//        }
//    }
//}
//
//#Preview {
//    LoginView()
//}
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false

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
                    Text("Login")
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
                        // Login action
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
                    
                    Button(action: {
                        // Register action
                    }) {
                        Text("Don't have an account? Register")
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

