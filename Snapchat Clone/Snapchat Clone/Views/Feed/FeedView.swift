//
//  FeedView.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 29/6/24.
//

import SwiftUI

struct FeedView: View {
    
    var feeds: [Feed]?
    
    var body: some View {
        NavigationStack{
            List(feeds ?? []) { feed in
                Text(feed.name)
            }
        }
        .navigationTitle("Feeds")
        
    }
}

#Preview {
    FeedView()
}
