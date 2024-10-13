//
//  Media.swift
//  mixtape
//
//  Created by Olin Johnson on 10/12/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Media {

    @Attribute(.externalStorage)
    var image: Data?
    
    var isrc: String?
    var songCover: String?
    var songName: String?
    var songArtist: String?
    
    init(image: Data? = nil, isrc: String? = nil, songCover: String? = nil, songName: String? = nil, songArtist: String? = nil) {
        self.image = image
        
        self.isrc = isrc
        self.songCover = songCover
        self.songName = songName
        self.songArtist = songArtist
    }
    
//    init(song: Song?) {
//        self.song = song
//        self.image = nil
//    }
    
}
