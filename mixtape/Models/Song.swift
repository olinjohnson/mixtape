//
//  Song.swift
//  mixtape
//
//  Created by Olin Johnson on 2/19/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Song {
    
    @Attribute(.unique)
    var id = UUID()
    var cover: Data
    var artist: String
    var name: String
    
    init(id: UUID, cover: Data, artist: String, name: String) {
        self.id = id
        self.cover = cover
        self.artist = artist
        self.name = name
    }
}

struct Album {
    var cover: Image
    var artist: String
    var name: String
    var songs: [Song]
}
