//
//  Entry.swift
//  mixtape
//
//  Created by Olin Johnson on 3/10/24.
//

import Foundation
import SwiftUI
import SwiftData
import UIKit

@Model
class Entry {
    
//    @Attribute(.unique)
    var id: UUID = UUID()
    
    @Attribute(.externalStorage)
    var cover: Data = Data()
    
    var title: String = ""
    var body: String = ""
    var date: Date = Date()
    
    var media: [Media]? = []
    
    init(id: UUID, cover: Data, title: String, body: String, date: Date, media: [Media]) {
        self.id = id
        self.cover = cover
        self.title = title
        self.body = body
        self.date = date
        self.media = media
    }
}

extension Entry {
    static var empty: Entry {
        return Entry(id: UUID(), cover: (UIImage(named: "no_select")?.pngData())!, title: "", body: "", date: Date(), media: [])
    }
}

/*
extension Entry {
    static let sample_entries: [Entry] = [
        Entry(id:UUID(), cover: (UIImage(named: "dog")?.pngData())!, title:"Feeling angry", body:"something awful happened at work today. I was going to go grab a coffee and then jack said", date:Date()),
        Entry(id:UUID(), cover: (UIImage(named: "dog")?.pngData())!, title:"WOOHOOOO", body:"I went to the carnival with my best friend john and we had an awesome time", date:Date()),
        Entry(id:UUID(), cover: (UIImage(named: "dog")?.pngData())!, title:"work day", body:"swamped with work today - had to work overtime and missed dinner", date:Date()),
    ]
}
*/
