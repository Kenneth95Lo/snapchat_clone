//
//  Feeds.swift
//  Snapchat Clone
//
//  Created by Kenneth Lo on 30/6/24.
//

import Foundation

struct Feed: Identifiable {
    let id: UUID
    let name: String
    let url: URL
}

struct Feeds {
    let feeds: [Feed]
}
