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
    
    @StateObject private var loginViewModel = LoginViewModel()
    
    private var loginDetails: AuthViewModel {
        return AuthViewModel(email: self.email, username: self.username, password: self.password)
    }
    
    func initCallbacks(){
        
        loginViewModel.userAuth = userAuth
        
        loginViewModel.loggedInCallback = { error in
            guard error == nil else {
                return triggerAlert(with: error?.localizedDescription ?? "Login failed..." )
            }
        }
        
        loginViewModel.signUpCallback = { error in
            guard error == nil else {
                return triggerAlert(with: error?.localizedDescription ?? "Sign up failed..." )
            }
        }
    }
    
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
            loginViewModel.doSignUp(model: loginDetails)
        }
    }
    
    func login() {
        if (isFieldsValidationPassed()){
            loginViewModel.doLogin(model: loginDetails)
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
        .onAppear {
            initCallbacks()
        }
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
