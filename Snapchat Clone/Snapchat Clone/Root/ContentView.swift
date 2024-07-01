//
//  ContentView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        Group {
            if loginViewModel.signedIn {
                TabViews()
            }else{
                SignInView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LoginViewModel())
}
