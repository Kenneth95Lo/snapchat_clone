//
//  AuthUtils.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

struct AuthViewModel: Codable {
    var email: String
    var username: String
    var password: String
}

//enum AuthUtilsError: Error {
//    case UnableToEncodeUser
//}

final class AuthUtils {
    
    typealias AuthFnCompletion = (Error?) -> Void
    
    static func createUser(model: AuthViewModel, completion: @escaping AuthFnCompletion){
        Auth.auth().createUser(withEmail: model.email, password: model.password) { auth, error in
            guard error == nil else {
                return completion(error)
            }
            
            let fireStore = Firestore.firestore()
            let userDict = ["email": model.email, "username": model.username]
            fireStore.collection("UserInfo").addDocument(data: userDict, completion: completion)
            completion(nil)
        }
    }
    
    static func loginUser(model: AuthViewModel, userAuth: UserAuth, completion: @escaping AuthFnCompletion){
        Auth.auth().signIn(withEmail: model.email, password: model.password) { authResult, error in
            guard error == nil else {
                return completion(error)
            }
            userAuth.currentUser = LoggedInUser(username: authResult?.user.displayName ?? "", email: authResult?.user.email ?? "")
            userAuth.userLoggedIn = true
            completion(nil)
        }
    }
    
    static func logout(userAuth: UserAuth,  completion: @escaping AuthFnCompletion){
        do {
            userAuth.currentUser = nil
            userAuth.userLoggedIn = false
            try Auth.auth().signOut()
            completion(nil)
        }catch{
            completion(error)
        }
    }
}
