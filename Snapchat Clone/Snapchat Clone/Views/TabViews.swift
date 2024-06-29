//
//  TabViews.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI

struct TabViews: View {
    var body: some View {
        TabView {
            FeedView().tabItem { Label("Feed", systemImage: "list.dash") }
            UploadView().tabItem { Label("Upload", systemImage: "list.dash") }
            SettingsView().tabItem { Label("Settings", systemImage: "list.dash") }
        }
    }
}

#Preview {
    TabViews()
}
