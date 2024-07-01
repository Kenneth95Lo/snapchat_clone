//
//  LoginViewModel.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 30/6/24.
//

import Foundation

struct User {
    var username: String
    var email: String
}

final class LoginViewModel: ObservableObject {
    
    @Published var user: User? = nil
    @Published var signedIn = false
    
    @Published var signUpCallback: ((Error?) -> Void)?
    @Published var loggedInCallback: ((Error?) -> Void)?
    @Published var logoutCallback: ((Bool) -> Void)?
    
    func doSignUp(model: AuthViewModel){
        AuthUtils.createUser(model: model) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.signUpCallback?(error)
                return
            }
            self.signUpCallback?(nil)
        }
    }
    
    func doLogin(model: AuthViewModel){
        AuthUtils.loginUser(model: model) { [weak self] result in
            guard let self = self else { return }
            switch(result){
            case .failure(let error):
                loggedInCallback?(error)
            case .success(let authDataResult):
                self.user = User(username: authDataResult?.user.displayName ?? "", email: authDataResult?.user.email ?? "")
                self.signedIn = true
                self.loggedInCallback?(nil)
            }
        }
    }
    
    func doLogout(){
        AuthUtils.logout { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.logoutCallback?(false)
                return
            }
            
            self.user = nil
            self.signedIn = false
            self.logoutCallback?(true)
        }
    }
}
