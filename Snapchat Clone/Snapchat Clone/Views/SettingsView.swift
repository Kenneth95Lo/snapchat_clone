//
//  SettingsView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var userAuth: UserAuth
    @State var shouldShowSignIn = false
    
    private var loginViewModel: LoginViewModel?
    
    init() {
        loginViewModel = LoginViewModel(userAuth: userAuth)
    }
    
    func initCallbacks(){
        loginViewModel?.logoutCallback = { success in
            guard success else {
                return
            }
        }
    }
    
    func logout(){
        loginViewModel?.doLogout()
    }
    
    var body: some View {
        Button("Logout"){
            logout()
        }
    }
}

#Preview {
    SettingsView().environmentObject(UserAuth())
}
