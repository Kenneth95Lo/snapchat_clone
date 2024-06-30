//
//  LoginViewModel.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 30/6/24.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    var userAuth: UserAuth?
    
//    init(userAuth: UserAuth) {
//        self.userAuth = userAuth
//    }
    
    @Published var signUpCallback: ((Error?) -> Void)?
    @Published var loggedInCallback: ((Error?) -> Void)?
    @Published var logoutCallback: ((Bool) -> Void)?
    
    func doSignUp(model: AuthViewModel){
        AuthUtils.createUser(model: model) { [weak self] error in
            guard error == nil else {
                self?.signUpCallback?(error)
                return
            }
            self?.signUpCallback?(nil)
        }
    }
    
    func doLogin(model: AuthViewModel){
        AuthUtils.loginUser(model: model) { [weak self] result in
            switch(result){
            case .failure(let error):
                self?.loggedInCallback?(error)
            case .success(let authDataResult):
                self?.userAuth?.currentUser = LoggedInUser(username: authDataResult?.user.displayName ?? "", email: authDataResult?.user.email ?? "")
                print(">>>>>>>>> ", self?.userAuth)
                self?.userAuth?.userLoggedIn = true
                self?.loggedInCallback?(nil)
            }
        }
    }
    
    func doLogout(){
        AuthUtils.logout { [weak self] error in
            guard error == nil else {
                self?.logoutCallback?(false)
                return
            }
            
            self?.userAuth?.currentUser = nil
            self?.userAuth?.userLoggedIn = false
            self?.logoutCallback?(true)
        }
    }
}
