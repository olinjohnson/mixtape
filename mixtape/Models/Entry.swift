//
//  Entry.swift
//  mixtape
//
//  Created by Olin Johnson on 3/10/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Entry {
    
    @Attribute(.unique)
    let id: UUID
    var cover: Image
    var title: String
    var body: String
    var date: Date
    // #TODO: COVER NEEDS TO BE AN OPTIONAL PARAM
    //var songs: [Song]
    // attachments, images, formatting options
    
    init(id: UUID, cover: Image, title: String, body: String, date: Date) {
        self.id = id
        self.cover = cover
        self.title = title
        self.body = body
        self.date = date
    }
}

/*
extension Entry {
    static let sample_entries: [Entry] = [
        Entry(id:UUID(), cover: Image("dog"), title:"Feeling angry", body:"something awful happened at work today. I was going to go grab a coffee and then jack said", date:Date()),
        Entry(id:UUID(), cover: Image("dog"), title:"WOOHOOOO", body:"I went to the carnival with my best friend john and we had an awesome time", date:Date()),
        Entry(id:UUID(), cover: Image("dog"), title:"work day", body:"swamped with work today - had to work overtime and missed dinner", date:Date()),
    ]
}
*/
