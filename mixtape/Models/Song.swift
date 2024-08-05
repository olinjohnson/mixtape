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
    
    var id: String
    var cover: String
    var artist: String
    var name: String
    
    var order: Int
    
    init(id: String, cover: String, artist: String, name: String, order: Int = 0) {
        self.id = id
        self.cover = cover
        self.artist = artist
        self.name = name
        self.order = order
    }
}

//struct Album {
//    var cover: Image
//    var artist: String
//    var name: String
//    var songs: [Song]
//}
