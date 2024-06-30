//
//  ContentView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @EnvironmentObject var userAuth: UserAuth
    
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var shouldShowAlert = false
    @State private var alertErrorMessage = ""
    @State private var shouldButtonsDisabled = false
    
    func isFieldsValidationPassed(shouldCheckUsername: Bool = false) -> Bool {
        var passed = password != "" && email != ""
        
        if shouldCheckUsername {
            passed = passed && (username != "")
        }
        
        if !passed {
            triggerAlert(with: "No empty fields allowed")
        }
        return passed
    }
    
    func signUp(){
        if (isFieldsValidationPassed(shouldCheckUsername: true)){
            AuthUtils.createUser(model: AuthViewModel(email: email, username: username, password: password)) { error in
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
            AuthUtils.loginUser(model: AuthViewModel(email: email, username: username, password: password), userAuth: userAuth) { error in
                guard error == nil else {
                    return triggerAlert(with: error?.localizedDescription ?? "Log in failed")
                }
//                userAuth.userLoggedIn = true
            }
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
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            HStack {
                Button("Login") {
                    login()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
    }
}

#Preview {
    SignInView()
        .environmentObject(UserAuth())
}

extension String {
    func makeText() -> Text {
        return Text(self)
    }
}
