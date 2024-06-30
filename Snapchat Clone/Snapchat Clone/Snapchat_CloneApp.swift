//
//  Snapchat_CloneApp.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI

struct LoggedInUser {
    var username: String
    var email: String
}

public class UserAuth: ObservableObject {
    @Published var userLoggedIn = false
    @Published var currentUser: LoggedInUser?
}

@main
struct Snapchat_CloneApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var userAuth = UserAuth()
    
    var body: some Scene {
        WindowGroup {
            if userAuth.userLoggedIn {
                TabViews()
            }else{
                SignInView()
            }
        }.environmentObject(userAuth)
    }
}
