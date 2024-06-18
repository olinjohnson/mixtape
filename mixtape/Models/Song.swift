//
//  Song.swift
//  mixtape
//
//  Created by Olin Johnson on 2/19/24.
//

import Foundation
import SwiftUI

struct Song: Identifiable {
    var cover: Image
    var artist: String
    var name: String
    let id = UUID()
}

struct Album {
    var cover: Image
    var artist: String
    var name: String
    var songs: [Song]
}
