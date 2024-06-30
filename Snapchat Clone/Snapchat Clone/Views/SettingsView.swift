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
    
    @State private var loginViewModel = LoginViewModel()
    
    func initCallbacks(){
        
        self.loginViewModel.userAuth = userAuth
        
        loginViewModel.logoutCallback = { success in
            guard success else {
                return
            }
        }
    }
    
    func logout(){
        loginViewModel.doLogout()
    }
    
    var body: some View {
        Button("Logout"){
            logout()
        }.onAppear{
            initCallbacks()
        }
    }
    
}

#Preview {
    SettingsView().environmentObject(UserAuth())
}
