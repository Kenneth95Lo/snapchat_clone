//
//  FeedView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI

struct Feed: Identifiable {
    var id: UUID
    var name: String
    var url: URL
}

struct FeedView: View {
    
    var feeds: [Feed]?
    
    var body: some View {
        List(feeds ?? []) { feed in
            Text(feed.name)
        }
    }
}

#Preview {
    FeedView()
}
