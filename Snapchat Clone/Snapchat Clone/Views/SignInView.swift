//
//  ContentView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var shouldShowAlert = false
    @State private var shouldShowAuthErrorAlert = false
    @State private var authErrorMessage = ""
    
    func login(){
        if (username != "" && password != "" && email != ""){
            AuthUtils.doAuth(model: AuthViewModel(email: email, username: username, password: password)) { error in
                guard error == nil else {
                    authErrorMessage = error?.localizedDescription ?? "Error"
                    shouldShowAuthErrorAlert = true
                    return
                }
                print("Signed up successfully")
            }
        }else{
            triggerAlert(show: true)
        }
        
        func triggerAlert(show: Bool){
            shouldShowAlert = show
        }
    }
    
    var body: some View {
        VStack {
            Text("Snapchat Clone")
                .font(.largeTitle)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Login") {
                login()
            }
            .padding()
            .alert(isPresented: $shouldShowAlert, content: {
                Alert(title: "Error".makeText(), message: "No empty field allowed".makeText())
            })
            .alert(isPresented: $shouldShowAuthErrorAlert, content: {
                Alert(title: "Error".makeText(), message: Text(authErrorMessage))
            })
            
        }
        .padding()
    }
}

#Preview {
    SignInView()
}

extension String {
    func makeText() -> Text {
        return Text(self)
    }
}
