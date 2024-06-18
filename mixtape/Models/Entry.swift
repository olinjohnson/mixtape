//
//  Entry.swift
//  mixtape
//
//  Created by Olin Johnson on 3/10/24.
//

import Foundation
import SwiftUI

struct Entry {
    var title: String
    var date: String
    var body: String
    // #TODO: COVER NEEDS TO BE AN OPTIONAL PARAM
    var cover: Image
    //var songs: [Song]
    // attachments, images, formatting options
}

extension Entry {
    static let sample_entries: [Entry] = [
        Entry(title:"Feeling angry", date:"March 1st 2024", body:"something awful happened at work today. I was going to go grab a coffee and then jack said", cover: Image("dog")),
        Entry(title:"Crazy weekend", date:"December 31st 2023", body:"this weekend was absolutely wild", cover: Image("dog")),
        Entry(title:"Hype for the holidays", date:"December 11th 2023", body:"I literally cannot wait nother day until christmas. Grandma is making her home made pie and driving up, its gonna be awesome.", cover: Image("dog")),
    ]
}
