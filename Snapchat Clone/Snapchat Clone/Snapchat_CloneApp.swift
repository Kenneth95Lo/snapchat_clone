//
//  Snapchat_CloneApp.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI

class UserAuth: ObservableObject {
    @Published var userLoggedIn = false
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
