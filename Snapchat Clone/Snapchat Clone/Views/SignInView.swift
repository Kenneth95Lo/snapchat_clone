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
    
    func isFieldsValidationPassed() -> Bool {
        let passed = username != "" && password != "" && email != ""
        if !passed {
            triggerAlert(with: "No empty fields allowed")
        }
        return passed
    }
    
    func signUp(){
        if (isFieldsValidationPassed()){
            AuthUtils.doAuth(model: AuthViewModel(email: email, username: username, password: password)) { error in
                guard error == nil else {
                    triggerAlert(with: error?.localizedDescription ?? "Error")
                    return
                }
                print("Signed up successfully")
            }
        }
    }
    
    func login() {
        if (isFieldsValidationPassed()){
            
        }
    }
    
    func triggerAlert(with message: String){
        alertErrorMessage = message
        shouldShowAlert = true
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
