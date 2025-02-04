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
    
    @Relationship(inverse: \Tape.songs) var tape: Tape?
    
//    var id: UUID
    // TODO: THIS SHOULD BE CHANGED FROM UUID TO ISRC
    var id: String?
    
    var cover: String = ""
    var artist: String = ""
    var name: String = ""
    var order: Double = 0.0
    var caption: String = ""
    
    init(id: String? = nil, cover: String, artist: String, name: String, order: Double = 0.0, caption: String) {
//        self.id = id
        self.id = id
        self.cover = cover
        self.artist = artist
        self.name = name
        self.order = order
        self.caption = caption
    }
}

//struct Album {
//    var cover: Image
//    var artist: String
//    var name: String
//    var songs: [Song]
//}
