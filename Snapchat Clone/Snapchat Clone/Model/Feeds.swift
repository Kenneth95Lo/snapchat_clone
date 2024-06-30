//
//  Feeds.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 30/6/24.
//

import Foundation

struct Feed: Identifiable {
    var id: UUID
    var name: String
    var url: URL
}

struct Feeds {
    var feeds: [Feed]
}
