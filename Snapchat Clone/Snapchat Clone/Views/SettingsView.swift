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
    
    func logout(){
        AuthUtils.logout(userAuth: userAuth) { error in
            guard error == nil else {
                return
            }
            
        }
        userAuth.userLoggedIn = false
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
