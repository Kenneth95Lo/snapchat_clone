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
    @State private var alertErrorMessage = ""
    @State private var shouldButtonsDisabled = false
    
    func signUp(){
        if (username != "" && password != "" && email != ""){
            AuthUtils.doAuth(model: AuthViewModel(email: email, username: username, password: password)) { error in
                guard error == nil else {
                    alertErrorMessage = error?.localizedDescription ?? "Error"
                    triggerAlert(show: true)
                    return
                }
                print("Signed up successfully")
            }
        }else{
            alertErrorMessage = "No empty fields allowed"
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
            HStack {
                Button("Login") {
//                    login()
                }
                .disabled(shouldButtonsDisabled)
                Button("Sign Up"){
                    signUp()
                }
                .padding()
                .alert(isPresented: $shouldShowAlert, content: {
                    Alert(title: "Error".makeText(), message: alertErrorMessage.makeText())
                })
                .disabled(shouldButtonsDisabled)
            }
            
            
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
